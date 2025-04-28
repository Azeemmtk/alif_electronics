import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileIncomeDetails extends StatelessWidget {
  const ProfileIncomeDetails({
    super.key,
    required this.totalIncome,
    required this.profitOrLose,
  });

  final double totalIncome;
  final double profitOrLose;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20.h,
        ),
        const Text(
          'Current month income',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '₹ $totalIncome',
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey),
        ),
        SizedBox(
          height: 20.h,
        ),
        Text(
          profitOrLose > 0 ? 'Profit' : 'Lose',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '₹ ${profitOrLose.abs()}',
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey),
        ),
      ],
    );
  }
}
