import 'package:alif_electronics/presentation/work/widgets/add_tv_details.dart';
import 'package:alif_electronics/presentation/work/widgets/customer_details.dart';
import 'package:alif_electronics/presentation/work/widgets/select_work_date.dart';
import 'package:alif_electronics/provider/work_provider.dart';
import 'package:alif_electronics/provider/wallet_provider.dart';
import 'package:alif_electronics/widgets/custom_appbar.dart';
import 'package:alif_electronics/widgets/customsnackbar.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:alif_electronics/widgets/custom_button.dart';
import 'package:alif_electronics/presentation/work/widgets/add_tv_image.dart';

class AddWorkScreen extends StatelessWidget {
  AddWorkScreen({super.key});

  final _formkey = GlobalKey<FormState>();
  final _cNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _complainController = TextEditingController();
  final _eAmountController = TextEditingController();
  final _aPaidController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final workProvider = Provider.of<WorkProvider>(context);
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);

    return Scaffold(
      appBar: customAppbar(
        navigation: () {
          workProvider.selectedDate = null;
          workProvider.imageFile = null;
          workProvider.webImageBytes = null;
          Navigator.pop(context);
        },
        context: context,
        icon: Icons.arrow_back,
        text: 'Add Works',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20.r,
            right: 20.r,
            bottom: 20.r,
            top: 10.r,
          ),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Customer Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    decoration: TextDecoration.underline,
                  ),
                ),
                CustomerDetails(
                  cNameController: _cNameController,
                  phoneController: _phoneController,
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black26,
                ),
                SizedBox(height: 10.h),
                const Text(
                  'TV Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    decoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(height: 20.h),
                AddTvDetails(
                    brandController: _brandController,
                    modelController: _modelController,
                    complainController: _complainController,
                    eAmountController: _eAmountController,
                    aPaidController: _aPaidController),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    const Text(
                      'Expected Date',
                      style: TextStyle(fontSize: 17),
                    ),
                    SizedBox(width: 10.w),
                    SelectWorkDate(workProvider: workProvider),
                  ],
                ),
                SizedBox(height: 20.h),
                AddTvImage(workProvider: workProvider),
                SizedBox(height: 20.h),
                CustomButton(
                  text: 'Add',
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      if (workProvider.selectedDate == null) {
                        customSnackbar(
                            context: context, Message: 'Please select a date');
                        return;
                      }
                      if (kIsWeb && workProvider.webImageBytes == null ||
                          !kIsWeb && workProvider.imageFile == null) {
                        customSnackbar(
                            context: context, Message: 'Please add an image');
                        return;
                      }
                      workProvider.saveWork(
                        customerName: _cNameController.text,
                        phoneNumber: _phoneController.text,
                        brandName: _brandController.text,
                        modelNumber: _modelController.text,
                        complaint: _complainController.text,
                        expectedAmount: _eAmountController.text,
                        advancePaid: _aPaidController.text,
                      );
                      walletProvider.getAllWork();
                      customSnackbar(
                          context: context, Message: 'Work added successfully');
                      _cNameController.clear();
                      _phoneController.clear();
                      _brandController.clear();
                      _modelController.clear();
                      _complainController.clear();
                      _eAmountController.clear();
                      _aPaidController.clear();
                      workProvider.selectedDate = null;
                      workProvider.imageFile = null;
                      workProvider.webImageBytes = null;
                      Navigator.pop(context);
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