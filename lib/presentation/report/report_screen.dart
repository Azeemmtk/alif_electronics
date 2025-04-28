import 'package:alif_electronics/constants/conts.dart';
import 'package:alif_electronics/presentation/report/monthly_report_screen.dart';
import 'package:alif_electronics/presentation/report/widgets/custom_chart.dart';
import 'package:alif_electronics/presentation/report/widgets/graph_details.dart';
import 'package:alif_electronics/presentation/report/widgets/monthly_weekly_tab.dart';
import 'package:alif_electronics/presentation/report/widgets/revenue_widget.dart';
import 'package:alif_electronics/provider/report_provider.dart';
import 'package:alif_electronics/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reportProvider = Provider.of<ReportProvider>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(13.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Income report',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                // decoration: TextDecoration.underline,
              ),
            ),
            SizedBox(height: 10.h),
            MonthlyWeeklyTab(reportProvider: reportProvider),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  reportProvider.selectedTab == 0
                      ? DateFormat('MMMM').format(DateTime.now())
                      : '',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
              ],
            ),
            Card(
              color: secondaryColor,
              child: Column(
                children: [
                  SizedBox(
                    height: 300.h,
                    width: 400.w,
                    child: CustomChart(
                      isMonthly: reportProvider.selectedTab == 0 ? true : false,
                    ),
                  ),
                  GraphDetails(reportProvider: reportProvider),
                  SizedBox(height: 10.h,),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            const RevenueWidget(),
            SizedBox(
              height: 20.h,
            ),
            CustomButton(
              text: 'Monthly report',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => const MonthlyReportScreen(),
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}