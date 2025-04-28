import 'package:alif_electronics/presentation/work/widgets/work_list.dart';
import 'package:alif_electronics/presentation/work/widgets/work_tabs.dart';
import 'package:alif_electronics/provider/work_provider.dart';
import 'package:alif_electronics/constants/conts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class WorkScreen extends StatelessWidget {
  const WorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WorkProvider>(context);
    final datas = provider.selectedTab == 0
        ? provider.pendingWork
        : provider.selectedTab == 1
            ? provider.inProgressWork
            : provider.completedWork;
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! < 0) {
          if (provider.selectedTab != 2) {
            provider.changeTab(provider.selectedTab+1);
          }
        } else if (details.primaryVelocity! > 0) {
          if (provider.selectedTab != 0) {
            provider.changeTab(provider.selectedTab-1);
          }
        }
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.r,right: 15.r,top: 15.r),
            child: WorkTabs(provider: provider),
          ),
          SizedBox(
            height: 20.h,
          ),
          datas.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height:MediaQuery.of(context).size.width<=394? 70.h: 18.h,
                      ),
                      Lottie.asset('assets/lottie/nodata.json'),
                      Text(
                        provider.selectedTab == 0
                            ? 'No works'
                            : provider.selectedTab == 1
                                ? 'Works not started'
                                : 'works not completed',
                        style: const TextStyle(
                          fontSize: 18,
                          color: mainColor,
                        ),
                      )
                    ],
                  ),
                )
              : WorkList(datas: datas, provider: provider),
        ],
      ),
    );
  }
}