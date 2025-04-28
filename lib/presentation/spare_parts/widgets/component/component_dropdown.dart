import 'package:alif_electronics/constants/conts.dart';
import 'package:alif_electronics/provider/spare_parts_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ComponentDropdown extends StatelessWidget {
  const ComponentDropdown({
    super.key,
    required this.provider,
  });

  final SparePartsProvider provider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      width: 150.w,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.blue[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: mainColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: mainColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: mainColor),
          ),
          contentPadding:
          EdgeInsets.symmetric(horizontal: 12.w),
        ),
        dropdownColor: Colors.blue[50],
        hint: const Text('Component',
            style: TextStyle(
                fontSize: 16,
                color: Colors.black)),
        value: provider
            .selectedValue, // Use current selected value
        items:
        provider.dropdownItems.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item,
                style: const TextStyle(fontSize: 16)),
          );
        }).toList(),
        onChanged: (newValue) =>
            provider.selectDropDownItem(newValue!),
      ),
    );
  }
}