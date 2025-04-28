import 'package:alif_electronics/widgets/custom_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditCustomerDetails extends StatelessWidget {
  const EditCustomerDetails({
    super.key,
    required TextEditingController cNameController,
    required TextEditingController phoneController,
  }) : _cNameController = cNameController, _phoneController = phoneController;

  final TextEditingController _cNameController;
  final TextEditingController _phoneController;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        SizedBox(
          height: 20.h,
        ),
        const Text(
          'Customer name',
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        CustomTextfiled(
          control: _cNameController,
          hint: 'Enter customer name',
        ),
        SizedBox(
          height: 10.h,
        ),
        const Text(
          'Phone Number',
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        CustomTextfiled(
          control: _phoneController,
          hint: 'Enter phone number',
        ),
        SizedBox(
          height: 5.h,
        ),
      ],
    );
  }
}