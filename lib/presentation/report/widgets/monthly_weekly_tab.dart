import 'package:alif_electronics/constants/conts.dart';
import 'package:alif_electronics/provider/report_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MonthlyWeeklyTab extends StatelessWidget {
  const MonthlyWeeklyTab({
    super.key,
    required this.reportProvider,
  });

  final ReportProvider reportProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
      width: 150.w,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                reportProvider.changeTab(0);
              },
              child: Container(
                height: 40.h,
                decoration: BoxDecoration(
                  color: reportProvider.selectedTab == 0
                      ? logoColor
                      : mainColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Monthly',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                reportProvider.changeTab(1);
              },
              child: Container(
                height: 40.h,
                decoration: BoxDecoration(
                  color: reportProvider.selectedTab == 1
                      ? logoColor
                      : mainColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Weekly',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
