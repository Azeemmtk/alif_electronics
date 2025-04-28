import 'package:alif_electronics/constants/conts.dart';
import 'package:alif_electronics/models/used_tv/used_tv_model.dart';
import 'package:alif_electronics/models/work/work_model.dart';
import 'package:alif_electronics/provider/report_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class RevenueWidget extends StatelessWidget {
  const RevenueWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final reportProvider = Provider.of<ReportProvider>(context);
    final List<UsedTvModel> filteredSoldUsedTV = reportProvider.getFilteredSoldUsedTv(context);
    final List<WorkModel> filteredCompletedPayments = reportProvider.getFilteredCompletedPayments(context);
    final double totalIncome = reportProvider.getTotalIncome(context);

    return Column(
      children: [
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Revenue',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              // color: mainColor,
              fontSize: 18,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text(
                  'From',
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(width: 10.w),
                GestureDetector(
                  onTap: () {
                    reportProvider.selectDate(context: context, isFrom: true);
                  },
                  child: Container(
                    height: 30,
                    width: 113,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(color: CupertinoColors.systemGrey),
                      color: Colors.blue[50],
                    ),
                    child: Center(
                      child: reportProvider.selectedFromDate == null
                          ? const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(Icons.date_range, size: 19),
                                Text(
                                  'Select date',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              '${reportProvider.selectedFromDate!.day}/${reportProvider.selectedFromDate!.month}/${reportProvider.selectedFromDate!.year}',
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'To',
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(width: 10.w),
                GestureDetector(
                  onTap: () {
                    reportProvider.selectDate(context: context, isFrom: false);
                  },
                  child: Container(
                    height: 30,
                    width: 113,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(color: CupertinoColors.systemGrey),
                      color: Colors.blue[50],
                    ),
                    child: Center(
                      child: reportProvider.selectedToDate == null
                          ? const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(Icons.date_range, size: 19),
                                Text(
                                  'Select date',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              '${reportProvider.selectedToDate!.day}/${reportProvider.selectedToDate!.month}/${reportProvider.selectedToDate!.year}',
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20.h),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(7.r),
            border: Border.all(color: Colors.black),
          ),
          child: filteredSoldUsedTV.isEmpty && filteredCompletedPayments.isEmpty
              ? SizedBox(
                  height: 200.h,
                  child:
                      const Center(child: Text('No data in the selected date range')))
              : Padding(
                  padding: EdgeInsets.all(13.r),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        filteredSoldUsedTV.isEmpty
                            ? const SizedBox()
                            : Column(
                                children: [
                                  const Text(
                                    'Sales',
                                    style: TextStyle(
                                      fontSize: 19,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: filteredSoldUsedTV.length,
                                    itemBuilder: (context, index) {
                                      final data = filteredSoldUsedTV[index];
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 100.w,
                                            child: Text(
                                              data.brandName,
                                              style: const TextStyle(fontSize: 17),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 120.w,
                                            child: Align(
                                              alignment:Alignment.center,
                                              child: Text(
                                                data.modelNumber,
                                                style: const TextStyle(fontSize: 17),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 100.w,
                                            child: Align(
                                              alignment:Alignment.centerRight,
                                              child: Text(
                                                '₹${data.marketPrice}',
                                                style: const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return SizedBox(height: 3.h);
                                    },
                                  ),
                                ],
                              ),
                        const Divider(),
                        SizedBox(height: 10.h),
                        filteredCompletedPayments.isEmpty
                            ? const SizedBox()
                            : Column(
                                children: [
                                  Text(
                                    'Services',
                                    style: TextStyle(
                                      fontSize: 19.sp,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: filteredCompletedPayments.length,
                                    itemBuilder: (context, index) {
                                      final data =
                                          filteredCompletedPayments[index];
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 100.w,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data.brandName,
                                                  style:
                                                      TextStyle(fontSize: 17.sp),
                                                ),
                                                Text(
                                                  data.modelNumber,
                                                  style:
                                                      TextStyle(fontSize: 17.sp),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 50.h,
                                            width: 120.w,
                                            child: Align(
                                              alignment:Alignment.center,
                                              child: Text(
                                                data.complaint,
                                                style:
                                                    TextStyle(fontSize: 17.sp),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 100.w,
                                            child: Align(
                                              alignment:Alignment.centerRight,
                                              child: Text(
                                                '₹${data.finalAmount}',
                                                style: TextStyle(
                                                  fontSize: 17.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return SizedBox(height: 6.h);
                                    },
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total amount',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            Text(
              '₹${totalIncome.toStringAsFixed(2)}/-',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
