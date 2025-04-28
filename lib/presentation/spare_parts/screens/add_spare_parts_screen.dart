import 'package:alif_electronics/constants/conts.dart';
import 'package:alif_electronics/presentation/spare_parts/screens/spare_parts_file_screen.dart';
import 'package:alif_electronics/presentation/spare_parts/widgets/component/add_or_see_new_component.dart';
import 'package:alif_electronics/presentation/spare_parts/widgets/spare_parts/add_spare_parts_button.dart';
import 'package:alif_electronics/presentation/spare_parts/widgets/spare_parts/add_spare_parts_fields.dart';
import 'package:alif_electronics/presentation/spare_parts/widgets/component/component_dropdown.dart';
import 'package:alif_electronics/presentation/spare_parts/widgets/spare_parts/spare_parts_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:alif_electronics/models/spare_parts/spare_parts_model.dart';
import 'package:alif_electronics/provider/spare_parts_provider.dart';
import 'package:alif_electronics/widgets/custom_appbar.dart';
import 'package:alif_electronics/widgets/custom_textfiled.dart';

class AddSparePartsScreen extends StatelessWidget {
  const AddSparePartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SparePartsProvider>(
      context,
      listen: true,
    );
    List<SparepartsModel> datas = provider.filteredSpareParts;
    final _modelController = TextEditingController();
    final _pro1Controller = TextEditingController();
    final _pro2Controller = TextEditingController();
    final _locationController = TextEditingController();
    final _priceController = TextEditingController();
    final _countController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    if (provider.selectedValue != null &&
        !provider.dropdownItems.contains(provider.selectedValue)) {
      provider.selectDropDownItem(null);
    }

    return Scaffold(
      appBar: customAppbar(
          context: context, icon: Icons.arrow_back, text: 'Add Spare parts'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextfiled(
                hint: 'Search parts...',
                preficon: Icons.search,
                onTap: () => provider.setIsSearching(true),
                onChanged: (value) => provider.searchSpareParts(value),
              ),
              SizedBox(height: 30.h),
              provider.isSearching
                  ? SparePartsSearchScreen(
                      datas: datas,
                      provider: provider,
                    )
                  : SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AddOrSeeNewComponent(),
                          SizedBox(height: 20.h),
                          const Text('Add new spare parts',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  decoration: TextDecoration.underline)),
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ComponentDropdown(provider: provider),
                              GestureDetector(
                                onTap: () async {
                                  await provider.printAllSpareParts();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute<void>(
                                          builder: (context) =>
                                              const SparePartsFileScreen()));
                                },
                                child: Container(
                                  height: 45.h,
                                  width: 150.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.blue[50],
                                    border: Border.all(color: mainColor),
                                  ),
                                  child: const Center(
                                      child: Text('Upload File',
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black))),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30.h),
                          Text(
                              '${provider.selectedValue ?? 'Component'} details',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  decoration: TextDecoration.underline)),
                          SizedBox(height: 20.h),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AddSparePartsFields(
                                    provider: provider,
                                    modelController: _modelController,
                                    pro1Controller: _pro1Controller,
                                    pro2Controller: _pro2Controller,
                                    locationController: _locationController,
                                    priceController: _priceController,
                                    countController: _countController),
                                SizedBox(height: 25.h),
                                AddSparePartsButton(
                                    formKey: _formKey,
                                    provider: provider,
                                    modelController: _modelController,
                                    pro1Controller: _pro1Controller,
                                    pro2Controller: _pro2Controller,
                                    locationController: _locationController,
                                    priceController: _priceController,
                                    countController: _countController),
                              ],
                            ),
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