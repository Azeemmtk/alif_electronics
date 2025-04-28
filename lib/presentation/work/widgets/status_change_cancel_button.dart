import 'package:alif_electronics/models/work/work_model.dart';
import 'package:alif_electronics/presentation/work/widgets/cancellation_reason_dialoge.dart';
import 'package:alif_electronics/provider/wallet_provider.dart';
import 'package:alif_electronics/provider/work_provider.dart';
import 'package:alif_electronics/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusChangeCancelButton extends StatelessWidget {
  const StatusChangeCancelButton({
    super.key,
    required this.provider,
    required this.data,
    required this.selectedTab,
    required this.walletProvider,
  });

  final WorkProvider provider;
  final WorkModel data;
  final int selectedTab;
  final WalletProvider walletProvider;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: (MediaQuery.of(context).size.width /
              2) -
              17.r,
          child: CustomButton(
              text: 'Cancel',
              onTap: () {
                showCancellationReasonDialog(
                    context, provider, data.workId);
              }),
        ),
        SizedBox(
          width: (MediaQuery.of(context).size.width /
              2) -
              17.r,
          child: CustomButton(
            text: selectedTab == 0
                ? 'Start work'
                : 'Complete Work',
            onTap: () {
              print(data.workId);
              selectedTab == 0
                  ? provider.updateWorkStatus(
                workId: data.workId,
                newStatus: 'In Progress',
              )
                  : provider.updateWorkStatus(
                workId: data.workId,
                newStatus: 'Completed',
              );
              walletProvider.getAllWork();
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
