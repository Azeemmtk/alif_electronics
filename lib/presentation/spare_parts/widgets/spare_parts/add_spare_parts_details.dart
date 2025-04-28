import 'package:alif_electronics/widgets/custom_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddSparePartsDetails extends StatelessWidget {
  AddSparePartsDetails({
    super.key,
    required this.text,
    required this.hint,
    required this.controller,
    this.isNum=false,
  });

  final String text;
  final String hint;
  final TextEditingController controller;
  final bool? isNum;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text( text,
          style: TextStyle(fontSize: 17),
        ),
        SizedBox(height: 5.h),
        CustomTextfiled(
          hint: hint,
          control: controller,
          isNum: isNum,
        ),
      ],
    );
  }
}