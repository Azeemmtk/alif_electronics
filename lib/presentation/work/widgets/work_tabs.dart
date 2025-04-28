import 'package:alif_electronics/provider/work_provider.dart';
import 'package:alif_electronics/constants/conts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkTabs extends StatelessWidget {
  const WorkTabs({
    super.key,
    required this.provider,
  });

  final WorkProvider provider;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      width: MediaQuery.of(context).size.width - 30.w,
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
                provider.changeTab(0);
              },
              child: Container(
                height: 45.h,
                decoration: BoxDecoration(
                  color: provider.selectedTab == 0 ? logoColor : mainColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Pending',
                    style: TextStyle(
                      color: provider.selectedTab == 0
                          ? const Color(0xFFFB0069)
                          : Colors.white,
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
                provider.changeTab(1);
              },
              child: Container(
                height: 45.h,
                decoration: BoxDecoration(
                  color: provider.selectedTab == 1 ? logoColor : mainColor,
                ),
                child: Center(
                  child: Text(
                    'In Progress',
                    style: TextStyle(
                      color: provider.selectedTab == 1
                          ? Colors.yellowAccent
                          : Colors.white,
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
                provider.changeTab(2);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: provider.selectedTab == 2 ? logoColor : mainColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Completed',
                    style: TextStyle(
                      color: provider.selectedTab == 2
                          ? const Color(0xFF326732)
                          : Colors.white,
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
