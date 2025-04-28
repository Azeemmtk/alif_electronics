import 'package:alif_electronics/presentation/report/widgets/build_row_details.dart';
import 'package:alif_electronics/provider/usedtv_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UsedTvReport extends StatelessWidget {
  const UsedTvReport({
    super.key,
    required this.usedTVProvider,
  });

  final UsedtvProvider usedTVProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Used TV\'s report',
          style: TextStyle(
            fontSize: 19,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: 6.h),
        buildRowDetails(
            text: 'Total TV sold',
            amount: usedTVProvider.currentMonthsoldtvcount.toDouble(),
            isCount: true),
        SizedBox(height: 3.h),
        buildRowDetails(
            text: 'Available',
            amount: usedTVProvider.availableUsedTv.length.toDouble(),
            isCount: true),
      ],
    );
  }
}
