import 'package:alif_electronics/provider/wallet_provider.dart';
import 'package:alif_electronics/widgets/custom_button.dart';
import 'package:alif_electronics/widgets/custom_textfiled.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../provider/work_provider.dart';

void showCancellationReasonDialog(
    BuildContext context, WorkProvider workProvider, String workId) {
  final TextEditingController _reasonController = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final walletProvider = Provider.of<WalletProvider>(context);
      return AlertDialog(
        title: const Text('Cancellation Reason'),
        content: CustomTextfiled(
          isExpand: true,
          control: _reasonController,
        ),
        backgroundColor: Colors.white,
        actions: [
          SizedBox(
            width: 120.w,
            child: CustomButton(
              text: 'Cancel',
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          SizedBox(
            width: 120.w,
            child: CustomButton(
              text: 'Submit',
              onTap: () {
                if (_reasonController.text.trim().isNotEmpty) {
                  workProvider.addCancellationReason(
                    workId: workId,
                    cancellationReason: _reasonController.text.trim(),
                  );
                  walletProvider.getAllWork();
                  Navigator.pop(context);
                  Navigator.pop(context);
                } else {
                  // Show a snackbar or some feedback if reason is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Please enter a cancellation reason')),
                  );
                }
              },
            ),
          )
        ],
      );
    },
  );
}
