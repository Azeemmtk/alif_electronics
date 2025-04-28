import 'dart:io';
import 'package:alif_electronics/constants/conts.dart';
import 'package:alif_electronics/models/work/work_model.dart';
import 'package:alif_electronics/presentation/wallet/widgets/tv_and_customer_detail_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TvOtherDetails extends StatelessWidget {
  const TvOtherDetails({
    super.key,
    required this.data,
  });

  final WorkModel data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TvAndCustomerDetailColumn(
                  data: data,
                  value: data.customerName,
                  head: 'Customer name',
                ),
                TvAndCustomerDetailColumn(
                  data: data,
                  value:
                      '${data.expectedDate.day}-${data.expectedDate.month}-${data.expectedDate.year}',
                  head: data.status == 'Completed'
                      ? 'Completed on:'
                      : 'Expected date:',
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10.h),
        TvAndCustomerDetailColumn(
            data: data, head: 'Phone number', value: data.phoneNumber),
        SizedBox(height: 10.h),
        TvAndCustomerDetailColumn(
            data: data, head: 'Payment method', value: data.paymentStatus),
        SizedBox(height: 20.h),
        Row(
          children: [
            Container(
              height: 130.w,
              width: 140.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: mainColor,
                ),
              ),
              child: data.imagePath != null && data.imagePath!.isNotEmpty
                  ? Hero(
                      tag: 'image-${data.workId}',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(9.r),
                        child: kIsWeb
                            ? Image.memory(
                                Uint8List.fromList(data.imagePath as List<int>),
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                  'assets/images/imglogo.png',
                                  fit: BoxFit.fill,
                                ),
                              )
                            : Image.file(
                                File(data.imagePath as String),
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                  'assets/images/imglogo.png',
                                  fit: BoxFit.fill,
                                ),
                              ),
                      ),
                    )
                  : const Placeholder(),
            ),
            SizedBox(width: 10.w),
            SizedBox(
              height: 130.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(data.brandName,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                      SizedBox(width: 5.w),
                      Text(data.modelNumber,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    ],
                  ),
                  Text(
                    'work id: ${data.workId}',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
