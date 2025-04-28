import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:alif_electronics/presentation/spare_parts/widgets/component/pick_image_for_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:alif_electronics/provider/spare_parts_provider.dart';
import 'package:alif_electronics/widgets/custom_appbar.dart';
import 'package:alif_electronics/widgets/custom_button.dart';
import 'package:alif_electronics/widgets/custom_textfiled.dart';
import 'package:alif_electronics/widgets/customsnackbar.dart';

class AddNewComponentScreen extends StatelessWidget {
  AddNewComponentScreen({super.key});

  final _categoryController = TextEditingController();
  final _prop1Controller = TextEditingController();
  final _prop2Controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SparePartsProvider>(context);

    return Scaffold(
      appBar: customAppbar(
          context: context, icon: Icons.arrow_back, text: 'Add new component'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.r),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25.h),
                Text('Category', style: TextStyle(fontSize: 17)),
                SizedBox(height: 5.h),
                CustomTextfiled(
                  hint: 'Enter category name',
                  control: _categoryController,
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                SizedBox(height: 30.h),
                Text('First property name', style: TextStyle(fontSize: 17)),
                SizedBox(height: 5.h),
                CustomTextfiled(
                  hint: 'Enter property name',
                  control: _prop1Controller,
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                SizedBox(height: 30.h),
                Text('Second property name', style: TextStyle(fontSize: 17)),
                SizedBox(height: 5.h),
                CustomTextfiled(
                  hint: 'Enter property name',
                  control: _prop2Controller,
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                SizedBox(height: 40.h),
                PickImageForComponent(provider: provider),
                SizedBox(height: 50.h),
                CustomButton(
                  text: 'Add',
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      final imagePath = kIsWeb
                          ? provider.webImageBytes?.toList()
                          : provider.imageFile?.path;
                      await provider.addNewCategory(
                        categoryName: _categoryController.text.trim(),
                        property1Name: _prop1Controller.text.trim(),
                        property2Name: _prop2Controller.text.trim(),
                        imagePath: imagePath,
                      );
                      customSnackbar(
                          context: context,
                          Message: 'New category added successfully!');
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
}