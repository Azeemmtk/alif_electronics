import 'package:alif_electronics/widgets/custom_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditTvDetails extends StatelessWidget {
  const EditTvDetails({
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
        Text(
          'TV Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            decoration: TextDecoration.underline,
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Text(
          'Brand name',
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        CustomTextfiled(
          control: _brandController,
          hint: 'Enter brand name',
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          'Model number',
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        CustomTextfiled(
          control: _modelController,
          hint: 'Enter Model number',
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          'Complaint',
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        CustomTextfiled(
          control: _complainController,
          isExpand: true,
          hint: 'Describe the issue...',
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          'Expected Amount',
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        CustomTextfiled(
          isNum: true,
          control: _eAmountController,
          hint: 'Enter expected amount',
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          'Advance Paid',
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        CustomTextfiled(
          isNum: true,
          control: _aPaidController,
          hint: 'Enter Advanced paid amount',
        ),
      ],
    );
  }
}