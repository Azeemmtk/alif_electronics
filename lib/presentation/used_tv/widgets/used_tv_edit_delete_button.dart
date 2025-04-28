import 'package:alif_electronics/presentation/used_tv/edit_usedtv_screen.dart';
import 'package:alif_electronics/provider/usedtv_provider.dart';
import 'package:alif_electronics/widgets/custom_button.dart';
import 'package:alif_electronics/widgets/customsnackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UsedTvEditDeleteButton extends StatelessWidget {
  const UsedTvEditDeleteButton({
    super.key,
    required this.provider,
    required this.widget,
    required GlobalKey<FormState> formkey,
    required TextEditingController brandController,
    required TextEditingController modelController,
    required TextEditingController detailsController,
    required TextEditingController purchasePriceController,
    required TextEditingController marketPriceController,
  }) : _formkey = formkey, _brandController = brandController, _modelController = modelController, _detailsController = detailsController, _purchasePriceController = purchasePriceController, _marketPriceController = marketPriceController;

  final UsedtvProvider provider;
  final EditUsedtvScreen widget;
  final GlobalKey<FormState> _formkey;
  final TextEditingController _brandController;
  final TextEditingController _modelController;
  final TextEditingController _detailsController;
  final TextEditingController _purchasePriceController;
  final TextEditingController _marketPriceController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: (MediaQuery.of(context).size.width / 2) - 20.r,
          child: CustomButton(
              text: 'Delete',
              onTap: () {
                provider.deleteUsedTv(widget.usedTv.usedTvId);
                Navigator.pop(context);
                Navigator.pop(context);
                customSnackbar(
                    context: context,
                    Message: "Used TV deleted successfully");
              }),
        ),
        SizedBox(
          width: (MediaQuery.of(context).size.width / 2) - 20.r,
          child: CustomButton(
            text: 'Update',
            onTap: () {
              if (_formkey.currentState!.validate()) {
                provider.updateUsedTv(
                  usedTvId: widget.usedTv.usedTvId,
                  brandName: _brandController.text,
                  modelNumber: _modelController.text,
                  details: _detailsController.text,
                  purchaseRate:
                  double.parse(_purchasePriceController.text),
                  marketPrice:
                  double.parse(_marketPriceController.text),
                );
                customSnackbar(
                    context: context,
                    Message: 'Used TV updated successfully');
                Navigator.pop(context);
              }
            },
          ),
        ),
      ],
    );
  }
}