import 'package:alif_electronics/constants/conts.dart';
import 'package:alif_electronics/provider/report_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GraphDetails extends StatelessWidget {
  const GraphDetails({
    super.key,
    required this.reportProvider,
  });

  final ReportProvider reportProvider;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 20.w,
        ),
        SizedBox(
          width: 20.w,
          child: const Divider(
            color: mainColor,
            thickness: 2,
          ),
        ),
        Text(
          reportProvider.selectedTab == 0
              ? ' Current Month'
              : ' Current week',
          style: const TextStyle(color: mainColor),
        ),
        SizedBox(
          width: 80.w,
        ),
        SizedBox(
          width: 20.w,
          child: const Divider(
            color: Colors.red,
            thickness: 2,
          ),
        ),
        Text(
          reportProvider.selectedTab == 0
              ? ' Previous Month'
              : ' Previous week',
          style: const TextStyle(color: Colors.red),
        )
      ],
    );
  }
}