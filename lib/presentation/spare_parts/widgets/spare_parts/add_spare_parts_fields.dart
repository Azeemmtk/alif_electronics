import 'package:alif_electronics/presentation/spare_parts/widgets/spare_parts/add_spare_parts_details.dart';
import 'package:alif_electronics/provider/spare_parts_provider.dart';
import 'package:alif_electronics/widgets/custom_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddSparePartsFields extends StatelessWidget {
  const AddSparePartsFields({
    super.key,
    required this.provider,
    required TextEditingController modelController,
    required TextEditingController pro1Controller,
    required TextEditingController pro2Controller,
    required TextEditingController locationController,
    required TextEditingController priceController,
    required TextEditingController countController,
  }) : _modelController = modelController, _pro1Controller = pro1Controller, _pro2Controller = pro2Controller, _locationController = locationController, _priceController = priceController, _countController = countController;

  final SparePartsProvider provider;
  final TextEditingController _modelController;
  final TextEditingController _pro1Controller;
  final TextEditingController _pro2Controller;
  final TextEditingController _locationController;
  final TextEditingController _priceController;
  final TextEditingController _countController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (provider.selectedValue != null &&
            provider.selectedValue != 'Capacitor') ...[
          Text('Model',
              style: TextStyle(fontSize: 17)),
          SizedBox(height: 5.h),
          CustomTextfiled(
              hint: 'Enter model number',
              control: _modelController),
          SizedBox(height: 15.h),
        ],
        AddSparePartsDetails(
          text: provider.selectedValue != null &&
              provider.customCategories.containsKey(
                  provider.selectedValue)
              ? provider.customCategories[
          provider.selectedValue]!['extra1']!
              : 'Add details',
          hint: provider.selectedValue == 'Resistor'
              ? 'watts (W)'
              : provider.selectedValue == 'Capacitor'
              ? 'millifarads (µF)'
              : provider.selectedValue ==
              'Transistor'
              ? 'voltage (v)'
              : provider.selectedValue == 'IC'
              ? 'voltage (v)'
              : 'Unit',
          controller: _pro1Controller,
          isNum: true,
        ),
        SizedBox(height: 15.h),
        AddSparePartsDetails(
          text: provider.selectedValue != null && provider.customCategories.containsKey(provider.selectedValue)
              ? provider.customCategories[provider.selectedValue]!['extra2']!
              : 'Add details',
          hint: provider.selectedValue == 'Resistor'
              ? ' ±( )%'
              : provider.selectedValue == 'Capacitor'
              ? 'voltage (v)'
              : provider.selectedValue ==
              'Transistor'
              ? 'milliampere (mA)'
              : provider.selectedValue == 'IC'
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
          text: 'Price', hint: 'Enter price', controller: _priceController,isNum: true,),
        SizedBox(height: 15.h),
        AddSparePartsDetails(
          text: 'Count',
          hint: 'Add count',
          controller: _countController,
          isNum: true,
        ),
      ],
    );
  }
}