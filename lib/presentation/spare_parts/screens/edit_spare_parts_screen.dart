import 'package:alif_electronics/constants/conts.dart';
import 'package:alif_electronics/models/spare_parts/spare_parts_model.dart';
import 'package:alif_electronics/presentation/spare_parts/widgets/spare_parts/add_spare_parts_details.dart';
import 'package:alif_electronics/presentation/spare_parts/widgets/spare_parts/delete_spare_parts_button.dart';
import 'package:alif_electronics/presentation/spare_parts/widgets/spare_parts/edit_spare_parts_fields.dart';
import 'package:alif_electronics/provider/spare_parts_provider.dart';
import 'package:alif_electronics/widgets/custom_appbar.dart';
import 'package:alif_electronics/widgets/custom_build_show_dialoge.dart';
import 'package:alif_electronics/widgets/custom_textfiled.dart';
import 'package:alif_electronics/widgets/customsnackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:alif_electronics/widgets/custom_button.dart';

class EditSparePartsScreen extends StatefulWidget {
  const EditSparePartsScreen({super.key, required this.data});

  final SparepartsModel data;

  @override
  State<EditSparePartsScreen> createState() => _EditSparePartsScreenState();
}

class _EditSparePartsScreenState extends State<EditSparePartsScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _modelController;
  late TextEditingController _pro1Controller;
  late TextEditingController _pro2Controller;
  late TextEditingController _locationController;
  late TextEditingController _priceController;
  late TextEditingController _countController;
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _modelController = TextEditingController(text: widget.data.model);
    _pro1Controller = TextEditingController(text: widget.data.extra1);
    _pro2Controller = TextEditingController(text: widget.data.extra2);
    _locationController = TextEditingController(text: widget.data.location);
    _priceController =
        TextEditingController(text: widget.data.price.toString());
    _countController =
        TextEditingController(text: widget.data.count.toString());
    _selectedCategory =
        widget.data.category; // Initialize with current category
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SparePartsProvider>(context);
    final categoryProps = provider.customCategories[_selectedCategory] ??
        {
          'extra1': 'Property 1',
          'extra2': 'Property 2',
        };

    return Scaffold(
      appBar: customAppbar(
        context: context,
        icon: Icons.arrow_back,
        text: 'Edit Spare parts',
        edit: DeleteSparePartsButton(widget: widget, provider: provider),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              SizedBox(
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
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                  ),
                  dropdownColor: Colors.blue[50],
                  hint: Text(
                    "Component",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  value: _selectedCategory,
                  items: provider.dropdownItems.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item, style: TextStyle(fontSize: 16)),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                      provider
                          .selectDropDownItem(newValue!); // Sync with provider
                    });
                  },
                ),
              ),
              SizedBox(height: 30.h),
              Text(
                '${_selectedCategory ?? 'Component'} details',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(height: 20.h),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EditSparePartsFields(selectedCategory: _selectedCategory, modelController: _modelController, categoryProps: categoryProps, pro1Controller: _pro1Controller, pro2Controller: _pro2Controller, locationController: _locationController, priceController: _priceController, countController: _countController),
                    SizedBox(height: 25.h),
                    CustomButton(
                      text: 'Edit',
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          await provider.editSpareParts(
                            currentModel: widget.data.model,
                            model: _modelController.text,
                            category: _selectedCategory ?? widget.data.category,
                            location: _locationController.text,
                            price: int.tryParse(_priceController.text) ?? 0,
                            count: int.tryParse(_countController.text) ?? 0,
                            extra1: _pro1Controller.text,
                            extra2: _pro2Controller.text,
                            img: widget.data.img, // Keeping original image
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Spare part updated successfully'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}