import 'package:alif_electronics/presentation/spare_parts/widgets/spare_parts/add_spare_parts_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditSparePartsFields extends StatelessWidget {
  const EditSparePartsFields({
    super.key,
    required String? selectedCategory,
    required TextEditingController modelController,
    required this.categoryProps,
    required TextEditingController pro1Controller,
    required TextEditingController pro2Controller,
    required TextEditingController locationController,
    required TextEditingController priceController,
    required TextEditingController countController,
  }) : _selectedCategory = selectedCategory, _modelController = modelController, _pro1Controller = pro1Controller, _pro2Controller = pro2Controller, _locationController = locationController, _priceController = priceController, _countController = countController;

  final String? _selectedCategory;
  final TextEditingController _modelController;
  final Map<String, String> categoryProps;
  final TextEditingController _pro1Controller;
  final TextEditingController _pro2Controller;
  final TextEditingController _locationController;
  final TextEditingController _priceController;
  final TextEditingController _countController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_selectedCategory != 'Capacitor') ...[
          AddSparePartsDetails(
              text: 'Model',
              hint: 'Enter model number',
              controller: _modelController),
          SizedBox(height: 15.h),
        ],
        AddSparePartsDetails(
          text: categoryProps['extra1']!,
          hint: _selectedCategory == 'Resistor'
              ? 'watts (W)'
              : _selectedCategory == 'Capacitor'
              ? 'millifarads (µF)'
              : _selectedCategory == 'Transistor'
              ? 'voltage (v)'
              : _selectedCategory == 'IC'
              ? 'voltage (v)'
              : 'Unit',
          controller: _pro1Controller,
          isNum: true,),
        SizedBox(height: 15.h),
        AddSparePartsDetails(
          text: categoryProps['extra2']!,
          hint: _selectedCategory == 'Resistor'
              ? ' ±( )%'
              : _selectedCategory == 'Capacitor'
              ? 'voltage (v)'
              : _selectedCategory == 'Transistor'
              ? 'milliampere (mA)'
              : _selectedCategory == 'IC'
              ? 'voltage (v)'
              : 'Unit',
          controller: _pro2Controller,
          isNum: true,
        ),
        SizedBox(height: 15.h),
        AddSparePartsDetails(
          text: 'Location',
          hint: 'Location in store',
          controller: _locationController,
        ),
        SizedBox(height: 15.h),
        AddSparePartsDetails(
          text: 'Price',
          hint: 'Enter price',
          controller: _priceController,
          isNum: true,
        ),
        SizedBox(height: 15.h),
        AddSparePartsDetails(
          text: 'Count',
          hint: 'Add count',
          controller: _countController,
        ),
      ],
    );
  }
}