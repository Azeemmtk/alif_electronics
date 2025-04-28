import 'package:alif_electronics/presentation/report/widgets/build_row_details.dart';
import 'package:alif_electronics/provider/wallet_provider.dart';
import 'package:alif_electronics/provider/work_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentReport extends StatelessWidget {
  const PaymentReport({
    super.key,
    required this.workProvider,
    required this.walletProvider,
  });

  final WorkProvider workProvider;
  final WalletProvider walletProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Payment reports',
          style: TextStyle(
            fontSize: 19,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: 6.h),
        buildRowDetails(
            text: 'Total amount received',
            amount: workProvider.totalFinalAmount),
        SizedBox(height: 3.h),
        buildRowDetails(
            text: 'Pending amount',
            amount: walletProvider.totalPendingAmount),
      ],
    );
  }
}