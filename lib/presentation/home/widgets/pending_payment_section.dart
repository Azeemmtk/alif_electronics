import 'package:alif_electronics/constants/conts.dart';
import 'package:alif_electronics/models/work/work_model.dart';
import 'package:alif_electronics/presentation/home/widgets/pending_payment_widget.dart';
import 'package:alif_electronics/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PendingPaymentSection extends StatelessWidget {
  const PendingPaymentSection({
    super.key,
    required this.homeProvider,
    required this.pendingData,
  });

  final HomeProvider homeProvider;
  final List<WorkModel> pendingData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Pending Payments',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: mainColor,
                fontSize: 17,
              ),
            ),
            GestureDetector(
              onTap: () {
                homeProvider.changeSelectedIndex(3);
              },
              child: const Text(
                'See all',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: mainColor,
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),
        pendingData.isEmpty
            ? Card(
          color: Colors.white,
          child: Container(
            height: 135.h,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: mainColor),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: const Center(
              child: Text(
                'No pending payments',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
            : PendingPaymentWidget(
          pendingData: pendingData,
        ),
      ],
    );
  }
}