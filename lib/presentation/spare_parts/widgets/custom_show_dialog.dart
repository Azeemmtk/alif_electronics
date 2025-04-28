import 'package:alif_electronics/constants/conts.dart';
import 'package:alif_electronics/widgets/custom_button.dart';
import 'package:alif_electronics/widgets/custom_textfiled.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../models/spare_parts/spare_parts_model.dart';
import 'custom_richtext.dart';

Future<dynamic> CustomShowDialog({
  required BuildContext context,
  required SparepartsModel data,
  required Function(String, int) increaseSparePartCount,
}) {
  final _formkey = GlobalKey<FormState>();
  final _countController = TextEditingController();
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Update count'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  height: 80,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    border: Border.all(color: mainColor),
                  ),
                  child: Image.asset(
                    data.img!,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${data.category}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    CustomRichtext(
                      mainText: 'Model ',
                      boldText: data.model,
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    CustomRichtext(
                      mainText: 'Count ',
                      boldText: data.count.toString(),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Form(
              key: _formkey,
              child: CustomTextfiled(
                hint: 'Add count',
                control: _countController,
              ),
            ),
          ],
        ),
        actions: [
          SizedBox(
            height: 40.h,
            width: 120.w,
            child: CustomButton(
              text: 'Cancel',
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          SizedBox(
            height: 40.h,
            width: 120.w,
            child: CustomButton(
              text: 'Save',
              onTap: () {
                if (_formkey.currentState!.validate()) {
                  int? newCount = int.tryParse(_countController.text);
                  increaseSparePartCount(data.model, newCount!);

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Count updated successfully")),
                  );
                }
              },
            ),
          ),
        ],
      );
    },
  );
}
