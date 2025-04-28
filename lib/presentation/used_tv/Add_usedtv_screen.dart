import 'package:alif_electronics/presentation/used_tv/widgets/used_tv_add_image.dart';
import 'package:alif_electronics/provider/usedtv_provider.dart';
import 'package:alif_electronics/widgets/custom_appbar.dart';
import 'package:alif_electronics/widgets/custom_button.dart';
import 'package:alif_electronics/widgets/customsnackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:alif_electronics/widgets/custom_textfiled.dart';

class AddUsedtvScreen extends StatelessWidget {
  AddUsedtvScreen({super.key});

  final _formkey = GlobalKey<FormState>();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _detailsController = TextEditingController();
  final _purchasePriceController = TextEditingController();
  final _marketPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UsedtvProvider>(context);
    return Scaffold(
      appBar: customAppbar(
        context: context,
        icon: Icons.arrow_back,
        text: 'Add Used TV\'s',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.r),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UsedTvAddImage(provider: provider),
                SizedBox(
                  height: 10.h,
                ),
                const Text(
                  'Brand Name',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                CustomTextfiled(
                  control: _brandController,
                  hint: 'Enter Brand name',
                ),
                SizedBox(
                  height: 10.h,
                ),
                const Text(
                  'Model Number',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                CustomTextfiled(
                  control: _modelController,
                  hint: 'Enter Model Number',
                ),
                SizedBox(
                  height: 10.h,
                ),
                const Text(
                  'Details',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                CustomTextfiled(
                  control: _detailsController,
                  hint: 'Enter the details',
                  isExpand: true,
                ),
                SizedBox(
                  height: 10.h,
                ),
                const Text(
                  'Purchase date',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                GestureDetector(
                  onTap: () {
                    provider.selectDate(context);
                  },
                  child: Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.r),
                      color: Colors.blue[50],
                    ),
                    child: Text(
                      provider.selectedDate == null
                          ? 'Select Purchase Date'
                          : '${provider.selectedDate!.day}/${provider.selectedDate!.month}/${provider.selectedDate!.year}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    const Text(
                      'Purchase Rate',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    SizedBox(
                      height: 60.h,
                      width: 100.w,
                      child: CustomTextfiled(
                        isNum: true,
                        control: _purchasePriceController,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    const Text(
                      'Market price',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      width:MediaQuery.of(context).size.width<=394? 35.w: 25.w ,
                    ),
                    SizedBox(
                      height: 60.h,
                      width: 100.w,
                      child: CustomTextfiled(
                        isNum: true,
                        control: _marketPriceController,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 25.h,
                ),
                CustomButton(
                  text: 'Add',
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      provider.saveUsedTv(
                        brandName: _brandController.text,
                        modelNumber: _modelController.text,
                        details: _detailsController.text,
                        purchaseRate:
                            double.tryParse(_purchasePriceController.text) ??
                                0.0,
                        marketPrice:
                            double.tryParse(_marketPriceController.text) ?? 0.0,
                      );
                      _brandController.clear();
                      _modelController.clear();
                      _detailsController.clear();
                      _purchasePriceController.clear();
                      _modelController.clear();

                      customSnackbar(
                        context: context,
                        Message: 'Used TV added successfully',
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}