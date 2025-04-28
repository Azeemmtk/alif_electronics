import 'package:alif_electronics/presentation/report/widgets/build_row_details.dart';
import 'package:alif_electronics/provider/spare_parts_provider.dart';
import 'package:alif_electronics/provider/work_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SparePartsReport extends StatelessWidget {
  const SparePartsReport({
    super.key,
    required this.sparePartsProvider,
    required this.workProvider,
  });

  final SparePartsProvider sparePartsProvider;
  final WorkProvider workProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Spare parts report',
          style: TextStyle(
            fontSize: 19,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: 6.h),
        buildRowDetails(
            text: 'Purchased expanse',
            amount: sparePartsProvider.totalSparePartsValue),
        SizedBox(height: 3.h),
        buildRowDetails(
            text: 'Total used',
            amount: workProvider.totalAllSparePartsUsedValue),
      ],
    );
  }
}