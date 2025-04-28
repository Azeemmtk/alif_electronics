import 'package:alif_electronics/presentation/spare_parts/screens/spare_parts_screen.dart';
import 'package:alif_electronics/presentation/spare_parts/widgets/spare_parts_build_category_section.dart';
import 'package:alif_electronics/provider/spare_parts_provider.dart';
import 'package:alif_electronics/widgets/custom_appbar.dart';
import 'package:alif_electronics/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:alif_electronics/widgets/customsnackbar.dart';
import 'package:alif_electronics/presentation/spare_parts/screens/add_spareparts_instruction.dart';

class SparePartsFileScreen extends StatelessWidget {
  const SparePartsFileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SparePartsProvider>(context);
    return Scaffold(
      appBar: customAppbar(
        context: context,
        icon: Icons.arrow_back,
        text: 'Upload file',
        edit: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const AddSparepartsInstruction(),
                ));
          },
          icon: const Icon(
            CupertinoIcons.info,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      provider.pickAndReadExcel(context);
                    },
                    child: Container(
                      height: 45.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.blue[50],
                      ),
                      child: const Center(
                        child: Text(
                          'Upload File',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40.w,
                  ),
                  const Icon(
                    Icons.note_add_outlined,
                  ),
                  Text(
                    provider.fileName,
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              const Text(
                'Preview',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 520.h,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.r),
                  child: ListView(
                    children: [
                      buildCategorySection('Resistors', provider.resistors),
                      buildCategorySection('Capacitors', provider.capacitors),
                      buildCategorySection('ICs', provider.ics),
                      buildCategorySection('Transistors', provider.transistors),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomButton(
                text: 'Add',
                onTap: () async {
                  final success = await provider.addSparepartsToHive(context);
                  if (success) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => const SparePartsScreen(),
                      ),
                          (route) => false,
                    );
                    customSnackbar(
                      Message: 'Spare parts added successfully!',
                      context: context,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}