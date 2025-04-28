import 'package:alif_electronics/presentation/used_tv/widgets/edit_date.dart';
import 'package:alif_electronics/presentation/used_tv/widgets/used_tv_edit_delete_button.dart';
import 'package:alif_electronics/presentation/used_tv/widgets/used_tv_edit_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:alif_electronics/models/used_tv/used_tv_model.dart';
import 'package:alif_electronics/provider/usedtv_provider.dart';
import 'package:alif_electronics/widgets/custom_appbar.dart';
import 'package:alif_electronics/widgets/custom_textfiled.dart';

class EditUsedtvScreen extends StatefulWidget {
  const EditUsedtvScreen({super.key, required this.usedTv});

  final UsedTvModel usedTv;

  @override
  State<EditUsedtvScreen> createState() => _EditUsedtvScreenState();
}

class _EditUsedtvScreenState extends State<EditUsedtvScreen> {
  late TextEditingController _brandController;
  late TextEditingController _modelController;
  late TextEditingController _detailsController;
  late TextEditingController _purchasePriceController;
  late TextEditingController _marketPriceController;
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _brandController = TextEditingController(text: widget.usedTv.brandName);
    _modelController = TextEditingController(text: widget.usedTv.modelNumber);
    _detailsController = TextEditingController(text: widget.usedTv.details);
    _purchasePriceController =
        TextEditingController(text: widget.usedTv.purchaseRate.toString());
    _marketPriceController =
        TextEditingController(text: widget.usedTv.marketPrice.toString());
  }

  @override
  void dispose() {
    _brandController.dispose();
    _modelController.dispose();
    _detailsController.dispose();
    _purchasePriceController.dispose();
    _marketPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UsedtvProvider>(context,);
    return Scaffold(
      appBar: customAppbar(
        context: context,
        icon: Icons.arrow_back,
        text: 'Edit Used TV\'s',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.r),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UsedTvEditImage(provider: provider, widget: widget),
                SizedBox(
                  height: 10.h,
                ),
                const Text(
                  'Brand Name',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                CustomTextfiled(
                  control: _brandController,
                  hint: 'Enter Brand name',
                ),
                SizedBox(
                  height: 10.h,
                ),
                const Text(
                  'Model Number',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                CustomTextfiled(
                  control: _modelController,
                  hint: 'Enter Model Number',
                ),
                SizedBox(
                  height: 10.h,
                ),
                const Text(
                  'Details',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                CustomTextfiled(
                  control: _detailsController,
                  hint: 'Enter the details',
                  isExpand: true,
                ),
                SizedBox(
                  height: 10.h,
                ),
                const Text(
                  'Purchase date',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                EditDate(provider: provider, widget: widget),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    const Text(
                      'Purchase Rate',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    SizedBox(
                      height: 60.h,
                      width: 100.w,
                      child: CustomTextfiled(
                        isNum: true,
                        control: _purchasePriceController,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    const Text(
                      'Market price',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      width:MediaQuery.of(context).size.width<=394? 35.w: 25.w ,
                    ),
                    SizedBox(
                      height: 60.h,
                      width: 100.w,
                      child: CustomTextfiled(
                        isNum: true,
                        control: _marketPriceController,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 25.h,
                ),
                UsedTvEditDeleteButton(
                    provider: provider,
                    widget: widget,
                    formkey: _formkey,
                    brandController: _brandController,
                    modelController: _modelController,
                    detailsController: _detailsController,
                    purchasePriceController: _purchasePriceController,
                    marketPriceController: _marketPriceController),
              ],
            ),
          ),
        ),
      ),
    );
  }
}