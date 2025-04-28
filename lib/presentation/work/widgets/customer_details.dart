import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/custom_textfiled.dart';

class CustomerDetails extends StatelessWidget {
  const CustomerDetails({
    super.key,
    required TextEditingController cNameController,
    required TextEditingController phoneController,
  })  : _cNameController = cNameController,
        _phoneController = phoneController;

  final TextEditingController _cNameController;
  final TextEditingController _phoneController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.h),
        Text(
          'Customer name',
          style: TextStyle(fontSize: 17),
        ),
        CustomTextfiled(
          control: _cNameController,
          hint: 'Enter customer name',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Customer name cannot be empty';
            }
            return null;
          },
        ),
        SizedBox(height: 10.h),
        Text(
          'Phone Number',
          style: TextStyle(fontSize: 17),
        ),
        CustomTextfiled(
          control: _phoneController,
          isNum: true,
          hint: 'Enter phone number',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Phone number cannot be empty';
            } else if (value.length != 10) {
              return 'Phone number must be 10 digits';
            }
            return null;
          },
        ),
        SizedBox(height: 5.h),
      ],
    );
  }
}
