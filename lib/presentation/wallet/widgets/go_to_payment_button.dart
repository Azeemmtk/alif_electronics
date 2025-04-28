import 'package:alif_electronics/models/work/work_model.dart';
import 'package:alif_electronics/presentation/wallet/widgets/payment_section.dart';
import 'package:alif_electronics/provider/spare_parts_provider.dart';
import 'package:alif_electronics/provider/wallet_provider.dart';
import 'package:alif_electronics/provider/work_provider.dart';
import 'package:alif_electronics/widgets/custom_button.dart';
import 'package:alif_electronics/widgets/customsnackbar.dart';
import 'package:flutter/material.dart';

class GoToPaymentButton extends StatelessWidget {
  const GoToPaymentButton({
    super.key,
    required TextEditingController serviceChargeController,
    required this.selectedParts,
    required this.totalAmount,
    required this.sparePartsProvider,
    required this.workProvider,
    required this.data,
    required this.walletProvider,
  }) : _serviceChargeController = serviceChargeController;

  final TextEditingController _serviceChargeController;
  final List<Map<String, dynamic>> selectedParts;
  final double totalAmount;
  final SparePartsProvider sparePartsProvider;
  final WorkProvider workProvider;
  final WorkModel data;
  final WalletProvider walletProvider;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'Goto Payment',
      onTap: () {
        if (double.tryParse(_serviceChargeController.text) ==
            null) {
          customSnackbar(
              context: context,
              Message: 'Please enter a valid service charge');
          return;
        }
        final serviceChargeValue =
        double.parse(_serviceChargeController.text);
        for (var part in selectedParts) {
          part['serviceCharge'] = serviceChargeValue;
        }
        showDialog(
          context: context,
          builder: (context) {
            return PaymentSection(
              totalAmount: totalAmount,
              selectedParts: selectedParts,
              sparePartsProvider: sparePartsProvider,
              workProvider: workProvider,
              data: data,
              walletProvider: walletProvider,
            );
          },
        );
      },
    );
  }
}