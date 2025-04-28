import 'package:alif_electronics/widgets/custom_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddTvDetails extends StatelessWidget {
  const AddTvDetails({
    super.key,
    required TextEditingController brandController,
    required TextEditingController modelController,
    required TextEditingController complainController,
    required TextEditingController eAmountController,
    required TextEditingController aPaidController,
  }) : _brandController = brandController, _modelController = modelController, _complainController = complainController, _eAmountController = eAmountController, _aPaidController = aPaidController;

  final TextEditingController _brandController;
  final TextEditingController _modelController;
  final TextEditingController _complainController;
  final TextEditingController _eAmountController;
  final TextEditingController _aPaidController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Brand name',
          style: TextStyle(fontSize: 17),
        ),
        CustomTextfiled(
          control: _brandController,
          hint: 'Enter brand name',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Brand name cannot be empty';
            }
            return null;
          },
        ),
        SizedBox(height: 10.h),
        const Text(
          'Model number',
          style: TextStyle(fontSize: 17),
        ),
        CustomTextfiled(
          control: _modelController,
          hint: 'Enter Model number',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Model number cannot be empty';
            }
            return null;
          },
        ),
        SizedBox(height: 10.h),
        const Text(
          'Complaint',
          style: TextStyle(fontSize: 17),
        ),
        CustomTextfiled(
          control: _complainController,
          isExpand: true,
          hint: 'Describe the issue...',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Complaint cannot be empty';
            }
            return null;
          },
        ),
        SizedBox(height: 10.h),
        const Text(
          'Expected Amount',
          style: TextStyle(fontSize: 17),
        ),
        CustomTextfiled(
          isNum: true,
          control: _eAmountController,
          hint: 'Enter expected amount',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Expected amount cannot be empty';
            }
            if (double.tryParse(value) == null) {
              return 'Enter a valid number';
            }
            return null;
          },
        ),
        SizedBox(height: 10.h),
        const Text(
          'Advance Paid',
          style: TextStyle(fontSize: 17),
        ),
        CustomTextfiled(
          isNum: true,
          control: _aPaidController,
          hint: 'Enter Advance paid amount',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Advance paid cannot be empty';
            }
            if (double.tryParse(value) == null) {
              return 'Enter a valid number';
            }
            return null;
          },
        ),
      ],
    );
  }
}