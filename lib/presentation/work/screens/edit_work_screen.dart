import 'dart:io';
import 'package:alif_electronics/models/work/work_model.dart';
import 'package:alif_electronics/provider/wallet_provider.dart';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:alif_electronics/presentation/work/widgets/edit_customer_details.dart';
import 'package:alif_electronics/presentation/work/widgets/edit_tv_details.dart';
import 'package:alif_electronics/presentation/work/widgets/edit_wprk_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:alif_electronics/provider/work_provider.dart';
import 'package:alif_electronics/widgets/custom_appbar.dart';
import 'package:alif_electronics/widgets/custom_button.dart';

class EditWorkScreen extends StatefulWidget {
  const EditWorkScreen({super.key, required this.works, required this.index});

  final int index;
  final WorkModel works;

  @override
  State<EditWorkScreen> createState() => _EditWorkScreenState();
}

class _EditWorkScreenState extends State<EditWorkScreen> {
  late TextEditingController _cNameController;
  late TextEditingController _phoneController;
  late TextEditingController _brandController;
  late TextEditingController _modelController;
  late TextEditingController _complainController;
  late TextEditingController _eAmountController;
  late TextEditingController _aPaidController;

  @override
  void initState() {
    super.initState();
    _cNameController = TextEditingController(text: widget.works.customerName);
    _phoneController = TextEditingController(text: widget.works.phoneNumber);
    _brandController = TextEditingController(text: widget.works.brandName);
    _modelController = TextEditingController(text: widget.works.modelNumber);
    _complainController = TextEditingController(text: widget.works.complaint);
    _eAmountController =
        TextEditingController(text: widget.works.expectedAmount);
    _aPaidController = TextEditingController(text: widget.works.advancePaid);
  }

  @override
  void dispose() {
    _cNameController.dispose();
    _phoneController.dispose();
    _brandController.dispose();
    _modelController.dispose();
    _complainController.dispose();
    _eAmountController.dispose();
    _aPaidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final workProvider = Provider.of<WorkProvider>(context);
    final walletProvider = Provider.of<WalletProvider>(context);
    return Scaffold(
      appBar: customAppbar(
        navigation: () {
          workProvider.selectedDate = null;
          workProvider.imageFile = null;
          Navigator.pop(context);
        },
        context: context,
        icon: Icons.arrow_back,
        text: 'Edit Works',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20.r,
            right: 20.r,
            bottom: 20.r,
            top: 10.r,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EditCustomerDetails(cNameController: _cNameController, phoneController: _phoneController),
              const Divider(
                thickness: 1,
                color: Colors.black26,
              ),
              SizedBox(
                height: 10.h,
              ),
              EditTvDetails(brandController: _brandController, modelController: _modelController, complainController: _complainController, eAmountController: _eAmountController, aPaidController: _aPaidController),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  const Text(
                    'Expected Date',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      workProvider.selectDate(context);
                    },
                    child: Container(
                      height: 30,
                      width: 113,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(
                          color: CupertinoColors.systemGrey,
                        ),
                        color: Colors.blue[50],
                      ),
                      child: Center(
                        child: workProvider.selectedDate == null
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Icon(
                                    Icons.date_range,
                                    size: 19,
                                  ),
                                  Text(
                                    '${widget.works.expectedDate.day}/${widget.works.expectedDate.month}/${widget.works.expectedDate.year}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                '${workProvider.selectedDate!.day}/${workProvider.selectedDate!.month}/${workProvider.selectedDate!.year}',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              EditWorkImage(provider: workProvider, widget: widget),
              SizedBox(
                height: 20.h,
              ),
              CustomButton(
                text: 'Update',
                onTap: () {
                  workProvider.updateWorkData(
                    workId: widget.works.workId,
                    customerName: _cNameController.text.trim(),
                    phoneNumber: _phoneController.text.trim(),
                    brandName: _brandController.text.trim(),
                    modelNumber: _modelController.text.trim(),
                    complaint: _complainController.text.trim(),
                    expectedAmount: _eAmountController.text.trim(),
                    advancePaid: _aPaidController.text.trim(),
                    expectedDate:
                    workProvider.selectedDate ?? widget.works.expectedDate,
                    imagePath:
                    kIsWeb
                        ? workProvider.webImageBytes?.toList() ??
                        widget.works.imagePath
                        : workProvider.imageFile?.path ?? widget.works.imagePath,
                  );
                  walletProvider.getAllWork();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Work updated successfully!')),
                  );

                  workProvider.selectedDate = null;
                  workProvider.imageFile = null;
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}