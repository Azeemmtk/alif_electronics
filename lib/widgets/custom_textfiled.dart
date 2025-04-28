import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextfiled extends StatelessWidget {
  CustomTextfiled({
    this.hint,
    this.preficon,
    this.isExpand = false,
    this.control,
    this.isNum = false,
    this.onChanged,
    this.onTap,
    this.focusNode,
    this.validator, // Add validator parameter
    super.key,
  });

  String? hint;
  IconData? preficon;
  bool? isExpand;
  TextEditingController? control;
  bool? isNum;
  Function(String)? onChanged;
  final VoidCallback? onTap;
  FocusNode? focusNode;
  final String? Function(String?)? validator; // Custom validator

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      onTap: onTap,
      focusNode: focusNode,
      controller: control,
      validator: validator ??
          (value) {
            // Default validator if none provided
            if (value == null || value.isEmpty) {
              return 'This field cannot be empty';
            }
            return null;
          },
      maxLines: isExpand! ? 4 : 1,
      keyboardType: isNum! ? TextInputType.number : null,
      decoration: InputDecoration(
        hintText: hint ?? '',
        hintStyle: const TextStyle(
          color: Color(0xFF8AAFC8),
        ),
        prefixIcon: preficon == null
            ? null
            : Icon(
                preficon,
                color: const Color(
                  0xFF8AAFC8,
                ),
              ),
        filled: true,
        fillColor: Colors.blue[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide:
              const BorderSide(color: CupertinoColors.systemGrey2, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide:
              const BorderSide(color: CupertinoColors.systemGrey2, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide:
              const BorderSide(color: CupertinoColors.systemGrey2, width: 2.0),
        ),
      ),
    );
  }
}
