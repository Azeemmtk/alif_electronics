import 'package:alif_electronics/presentation/report/widgets/build_row_details.dart';
import 'package:alif_electronics/provider/work_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RepairSummery extends StatelessWidget {
  const RepairSummery({
    super.key,
    required this.workProvider,
  });

  final WorkProvider workProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Repair summary',
          style: TextStyle(
            fontSize: 19,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: 6.h),
        buildRowDetails(
            text: 'Total repair completed',
            amount: workProvider.currentMonthCompletedWorkCount.toDouble(),
            isCount: true),
        SizedBox(height: 3.h),
        buildRowDetails(
            text: 'Pending works',
            amount: workProvider.currentMonthPendingWorkCount.toDouble(),
            isCount: true),
        SizedBox(height: 3.h),
        buildRowDetails(
            text: 'Started works',
            amount: workProvider.currentMonthInProgressWorkCount.toDouble(),
            isCount: true),
        SizedBox(height: 3.h),
        buildRowDetails(
            text: 'Work cancelled',
            amount: workProvider.currentMonthCancelledWorkCount.toDouble(),
            isCount: true),
      ],
    );
  }
}