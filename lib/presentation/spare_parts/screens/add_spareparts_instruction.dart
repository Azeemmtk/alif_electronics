import 'package:alif_electronics/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/excel_formate_row.dart';

class AddSparepartsInstruction extends StatelessWidget {
  const AddSparepartsInstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        context: context,
        icon: Icons.arrow_back,
        text: 'Excel file format',
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
              const Text(
                'Add data to you\'r Excel file as below',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30.h,
              ),
              Image.asset(
                'assets/images/excel.png',
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'There are 7 data(Column) to add',
                style: GoogleFonts.roboto(
                  decoration: TextDecoration.underline,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              ExcelFormatRow(
                text: 'Spare parts name',
                column: 1,
              ),
              SizedBox(
                height: 15.h,
              ),
              ExcelFormatRow(
                text: 'Model number',
                column: 2,
              ),
              SizedBox(
                height: 15.h,
              ),
              ExcelFormatRow(
                column: 3,
                text:
                    'First property(Main property like if it\'s a Resister then Power rate or it\'s a Capacitor then capacitance or it\'s a IC then output etc... )',
              ),
              SizedBox(
                height: 15.h,
              ),
              ExcelFormatRow(
                text:
                    'Second property(If it\'s a Resister then tolerance or it\'s a Capacitor then voltage or it\'s a IC then input range etc... )',
                column: 4,
              ),
              SizedBox(
                height: 15.h,
              ),
              ExcelFormatRow(
                text:
                    'Location (Spare parts location in your shop like a box or shelf number)',
                column: 5,
              ),
              SizedBox(
                height: 15.h,
              ),
              ExcelFormatRow(
                text: 'Price of the spare parts',
                column: 6,
              ),
              SizedBox(
                height: 15.h,
              ),
              ExcelFormatRow(
                text: 'Count of the spare parts',
                column: 7,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
