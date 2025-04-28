import 'package:alif_electronics/models/used_tv/used_tv_model.dart';
import 'package:alif_electronics/presentation/used_tv/edit_usedtv_screen.dart';
import 'package:alif_electronics/provider/usedtv_provider.dart';
import 'package:alif_electronics/widgets/custom_button.dart';
import 'package:alif_electronics/widgets/customsnackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UsedTvDetailsButton extends StatelessWidget {
  const UsedTvDetailsButton({
    super.key,
    required this.data,
    required this.provider,
  });

  final UsedTvModel data;
  final UsedtvProvider provider;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width:
          (MediaQuery.of(context).size.width / 2) - 20.r,
          child: CustomButton(
            text: 'Edit',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => EditUsedtvScreen(
                    usedTv: data,
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          width:
          (MediaQuery.of(context).size.width / 2) - 20.r,
          child: CustomButton(
            text: 'Sell',
            onTap: () {
              provider.markAsSold(data.usedTvId);
              Navigator.pop(context);
              customSnackbar(
                  context: context,
                  Message: 'Used TV deleted successfully');
            },
          ),
        )
      ],
    );
  }
}