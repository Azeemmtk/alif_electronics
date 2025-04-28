import 'package:alif_electronics/constants/conts.dart';
import 'package:alif_electronics/models/used_tv/used_tv_model.dart';
import 'package:alif_electronics/presentation/home/widgets/used_tv_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UsedTvSection extends StatelessWidget {
  const UsedTvSection({
    super.key,
    required this.usedTVData,
  });

  final List<UsedTvModel> usedTVData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Used Tv\'s',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: mainColor,
            fontSize: 17,
          ),
        ),
        usedTVData.isEmpty
            ?  Card(
          color: Colors.white,
          elevation: 6,
          child: Container(
            height: 260.h,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: mainColor),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: const Center(
              child: Text(
                'Currently no \n used TV available',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
            : UsedTvWidget(
          usedTVData: usedTVData,
        ),
      ],
    );
  }
}