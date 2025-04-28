import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alif_electronics/provider/report_provider.dart';

class CustomChart extends StatelessWidget {

  const CustomChart({super.key, required this.isMonthly});
  final bool isMonthly;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now().toUtc();
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0).day;

    final currentDayOfWeek = now.weekday;
    final daysToMonday = (currentDayOfWeek - 1);
    final startOfWeek = now.subtract(Duration(days: daysToMonday));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    final double maxX = isMonthly ? lastDayOfMonth.toDouble() : 7.0;

    final double verticalInterval = isMonthly ? 5.0 : 1.0;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            horizontalInterval: 5000,
            verticalInterval: verticalInterval,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                  color: Colors.grey.withOpacity(0.2), strokeWidth: 1);
            },
            getDrawingVerticalLine: (value) {
              return FlLine(
                  color: Colors.grey.withOpacity(0.2), strokeWidth: 1);
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: verticalInterval,
                getTitlesWidget: (value, meta) {
                  final day = value.toInt();
                  if (day < 1 || day > maxX) return const Text('');
                  return Text(day.toString(),
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black));
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 25,
                interval: 5000,
                getTitlesWidget: (value, meta) {
                  return Text('${(value / 1000).toInt()}k',
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black));
                },
              ),
            ),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(
              show: true,
              border:
                  Border.all(color: Colors.grey.withOpacity(0.5), width: 1)),
          minX: 1,
          maxX: maxX,
          minY: 0,
          maxY: _getMaxY(context, isMonthly),
          lineBarsData: [
            LineChartBarData(
              spots: _addEdgePointsWithInterpolation(
                  isMonthly
                      ? _getCurrentMonthData(context)
                      : _getCurrentWeekData(context, endOfWeek),
                  maxX),
              isCurved: true,
              curveSmoothness: 0.2,
              color: Colors.blue,
              barWidth: 2,
              belowBarData: BarAreaData(
                show: true,
                color: Colors.blue.withOpacity(0.1),
              ),
              dotData: const FlDotData(show: false),
              preventCurveOverShooting: true,
            ),
            LineChartBarData(
              spots: _addEdgePointsWithInterpolation(
                  isMonthly
                      ? _getPreviousMonthData(context)
                      : _getPreviousWeekData(context, endOfWeek),
                  maxX),
              isCurved: true,
              curveSmoothness: 0.2,
              color: Colors.red,
              barWidth: 2,
              belowBarData: BarAreaData(
                show: true,
                color: Colors.red.withOpacity(0.1),
              ),
              dotData: const FlDotData(show: false),
              preventCurveOverShooting: true,
            ),
          ],
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  final day = spot.x.toInt();
                  final income = spot.y.toInt().clamp(0, double.infinity);
                  return LineTooltipItem(
                    'Day $day\n₹$income',
                    TextStyle(
                        color: spot.bar.color ?? Colors.black,
                        fontWeight: FontWeight.bold),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }

  double _getMaxY(BuildContext context, bool isMonthly) {
    final currentData = isMonthly
        ? _getCurrentMonthData(context)
        : _getCurrentWeekData(
            context, DateTime.now().toUtc().add(const Duration(days: 6)));
    final previousData = isMonthly
        ? _getPreviousMonthData(context)
        : _getPreviousWeekData(
            context, DateTime.now().toUtc().add(const Duration(days: 6)));
    final allSpots = [...currentData, ...previousData];
    if (allSpots.isEmpty) return 10000;
    final maxIncome =
        allSpots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);
    return (maxIncome * 1.2).ceilToDouble().clamp(0, double.infinity);
  }

  List<FlSpot> _getCurrentMonthData(BuildContext context) {
    final now = DateTime.now().toUtc();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0);
    return _aggregateIncomeData(context, startOfMonth, endOfMonth);
  }

  List<FlSpot> _getPreviousMonthData(BuildContext context) {
    final now = DateTime.now().toUtc();
    final startOfPreviousMonth = DateTime(now.year, now.month - 1, 1);
    final endOfPreviousMonth = DateTime(now.year, now.month, 0);
    return _aggregateIncomeData(
        context, startOfPreviousMonth, endOfPreviousMonth);
  }

  List<FlSpot> _getCurrentWeekData(BuildContext context, DateTime endOfWeek) {
    final now = DateTime.now().toUtc();
    final currentDayOfWeek = now.weekday;
    final daysToMonday = (currentDayOfWeek - 1);
    final startOfWeek = now.subtract(Duration(days: daysToMonday));
    return _aggregateIncomeData(context, startOfWeek, endOfWeek,
        isWeekly: true);
  }

  List<FlSpot> _getPreviousWeekData(BuildContext context, DateTime endOfWeek) {
    final now = DateTime.now().toUtc();
    final currentDayOfWeek = now.weekday;
    final daysToMonday = (currentDayOfWeek - 1);
    final startOfWeek = now.subtract(Duration(days: daysToMonday));
    final endOfPreviousWeek = startOfWeek.subtract(const Duration(days: 1));
    final startOfPreviousWeek = endOfPreviousWeek.subtract(const Duration(days: 6));
    return _aggregateIncomeData(context, startOfPreviousWeek, endOfPreviousWeek,
        isWeekly: true);
  }

  List<FlSpot> _aggregateIncomeData(
      BuildContext context, DateTime startDate, DateTime endDate,
      {bool isWeekly = false}) {
    final reportProvider = Provider.of<ReportProvider>(context, listen: false);

    final normalizedStartDate =
        DateTime.utc(startDate.year, startDate.month, startDate.day);
    final normalizedEndDate =
        DateTime.utc(endDate.year, endDate.month, endDate.day, 23, 59, 59);

    final soldTvs = reportProvider.getFilteredSoldUsedTv(context).where((tv) {
      final soldDate = tv.soldDate?.toUtc() ?? DateTime.now().toUtc();
      final isWithinRange =
          soldDate.isAfter(normalizedStartDate.subtract(const Duration(days: 1))) &&
              soldDate.isBefore(normalizedEndDate.add(const Duration(days: 1)));
      print(
          'TV Sold Date: $soldDate, Amount: ${tv.marketPrice}, Within Range: $isWithinRange');
      return isWithinRange;
    }).toList();
    final completedPayments =
        reportProvider.getFilteredCompletedPayments(context).where((work) {
      final expectedDate = work.expectedDate.toUtc();
      final isWithinRange = expectedDate
              .isAfter(normalizedStartDate.subtract(const Duration(days: 1))) &&
          expectedDate.isBefore(normalizedEndDate.add(const Duration(days: 1)));
      print(
          'Payment Date: $expectedDate, Amount: ${work.finalAmount}, Within Range: $isWithinRange');
      return isWithinRange;
    }).toList();

    final daysInRange =
        normalizedEndDate.difference(normalizedStartDate).inDays + 1;
    final Map<int, double> dailyIncome = {};

    for (int i = 0; i < daysInRange; i++) {
      dailyIncome[i + 1] = 0.0;
    }

    for (var tv in soldTvs) {
      final soldDate = tv.soldDate?.toUtc() ?? DateTime.now().toUtc();
      final dayOffset = soldDate.difference(normalizedStartDate).inDays + 1;
      if (dayOffset >= 1 && dayOffset <= daysInRange) {
        dailyIncome[dayOffset] = (dailyIncome[dayOffset] ?? 0.0) +
            tv.marketPrice.clamp(0, double.infinity);
      } else {
        print('Invalid dayOffset for TV: $dayOffset, Date: $soldDate');
      }
    }

    for (var work in completedPayments) {
      final dayOffset =
          work.expectedDate.difference(normalizedStartDate).inDays + 1;
      if (dayOffset >= 1 && dayOffset <= daysInRange) {
        dailyIncome[dayOffset] = (dailyIncome[dayOffset] ?? 0.0) +
            (work.finalAmount ?? 0.0).clamp(0, double.infinity);
      } else {
        print(
            'Invalid dayOffset for Payment: $dayOffset, Date: $work.expectedDate');
      }
    }

    return dailyIncome.entries
        .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
        .toList();
  }

  // Enhanced edge points with interpolation for all days
  List<FlSpot> _addEdgePointsWithInterpolation(
      List<FlSpot> spots, double maxX) {
    if (spots.isEmpty) {
      final result = <FlSpot>[];
      for (int i = 1; i <= maxX.toInt(); i++) {
        result.add(FlSpot(i.toDouble(), 0));
      }
      return result;
    }

    final List<FlSpot> result = [const FlSpot(1, 0)];
    final int maxDay = maxX.toInt();

    // Add all days from 1 to maxX with 0 where no data
    for (int i = 2; i <= maxDay; i++) {
      final existingSpot = spots.firstWhere((spot) => spot.x.toInt() == i,
          orElse: () => FlSpot(i.toDouble(), 0));
      result.add(existingSpot);
    }

    return result;
  }
}
