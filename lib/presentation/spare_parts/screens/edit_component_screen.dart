import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb, Uint8List;
import 'package:alif_electronics/presentation/spare_parts/widgets/spare_parts/add_spare_parts_details.dart';
import 'package:alif_electronics/presentation/spare_parts/widgets/component/delete_component_button.dart';
import 'package:alif_electronics/presentation/spare_parts/widgets/component/pick_image_for_component.dart';
import 'package:alif_electronics/provider/spare_parts_provider.dart';
import 'package:alif_electronics/widgets/custom_appbar.dart';
import 'package:alif_electronics/widgets/custom_button.dart';
import 'package:alif_electronics/widgets/customsnackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class EditComponentScreen extends StatefulWidget {
  const EditComponentScreen({super.key, this.categoryToEdit});
  final String? categoryToEdit;

  @override
  State<EditComponentScreen> createState() => _EditComponentScreenState();
}

class _EditComponentScreenState extends State<EditComponentScreen> {
  late TextEditingController _categoryController;
  late TextEditingController _prop1Controller;
  late TextEditingController _prop2Controller;
  final _formKey = GlobalKey<FormState>();
  bool _isEditMode = false;
  static const List<String> defaultCategories = [
    'Resistor',
    'Capacitor',
    'Transistor',
    'IC'
  ];

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<SparePartsProvider>(context, listen: false);
    _categoryController = TextEditingController();
    _prop1Controller = TextEditingController();
    _prop2Controller = TextEditingController();

    if (widget.categoryToEdit != null &&
        !defaultCategories.contains(widget.categoryToEdit)) {
      _isEditMode = true;
      final categoryData = provider.customCategories[widget.categoryToEdit];
      _categoryController.text = widget.categoryToEdit!;
      _prop1Controller.text = categoryData?['extra1'] ?? '';
      _prop2Controller.text = categoryData?['extra2'] ?? '';
      final imagePath = categoryData?['imagePath'];
      if (imagePath != null && imagePath != 'Unknown') {
        if (kIsWeb) {
          // Parse stringified List<int> for web
          try {
            if (imagePath.startsWith('[') && imagePath.endsWith(']')) {
              final cleaned = imagePath.substring(1, imagePath.length - 1).trim();
              if (cleaned.isNotEmpty) {
                final numbers = cleaned.split(',').map((e) => int.tryParse(e.trim()));
                if (!numbers.any((n) => n == null)) {
                  provider.webImageBytes = Uint8List.fromList(numbers.cast<int>().toList());
                }
              }
            }
          } catch (e) {
            print('Error parsing web image in initState: $e');
          }
        } else {
          // Mobile: Set File
          final file = File(imagePath);
          if (file.existsSync()) {
            provider.imageFile = file;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SparePartsProvider>(context);

    return Scaffold(
      appBar: customAppbar(
        context: context,
        icon: Icons.arrow_back,
        text: _isEditMode ? 'Edit Component' : 'Add New Component',
        edit: _isEditMode
            ? DeleteComponentButton(widget: widget, provider: provider)
            : null,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.r),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25.h),
                AddSparePartsDetails(
                  text: 'Category',
                  hint: 'Enter category name',
                  controller: _categoryController,
                ),
                SizedBox(height: 30.h),
                AddSparePartsDetails(
                  text: 'First property name',
                  hint: 'Enter property name',
                  controller: _prop1Controller,
                ),
                SizedBox(height: 30.h),
                AddSparePartsDetails(
                  text: 'Second property name',
                  hint: 'Enter property name',
                  controller: _prop2Controller,
                ),
                SizedBox(height: 40.h),
                PickImageForComponent(provider: provider),
                SizedBox(height: 50.h),
                CustomButton(
                  text: _isEditMode ? 'Update' : 'Add',
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      final imagePath = kIsWeb
                          ? provider.webImageBytes?.toList()
                          : provider.imageFile?.path;
                      if (_isEditMode) {
                        await provider.editCategory(
                          oldCategoryName: widget.categoryToEdit!,
                          newCategoryName: _categoryController.text.trim(),
                          property1Name: _prop1Controller.text.trim(),
                          property2Name: _prop2Controller.text.trim(),
                          imagePath: imagePath,
                        );
                        customSnackbar(
                            context: context,
                            Message: 'Component updated successfully!');
                      } else {
                        if (defaultCategories
                            .contains(_categoryController.text.trim())) {
                          customSnackbar(
                            context: context,
                            Message: 'Cannot add default category!',
                          );
                        } else {
                          await provider.addNewCategory(
                            categoryName: _categoryController.text.trim(),
                            property1Name: _prop1Controller.text.trim(),
                            property2Name: _prop2Controller.text.trim(),
                            imagePath: imagePath,
                          );
                          customSnackbar(
                              context: context,
                              Message: 'New category added successfully!');
                        }
                      }
                      provider.imageFile = null;
                      provider.webImageBytes = null;
                      _categoryController.clear();
                      _prop1Controller.clear();
                      _prop2Controller.clear();
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _categoryController.dispose();
    _prop1Controller.dispose();
    _prop2Controller.dispose();
    super.dispose();
  }
}