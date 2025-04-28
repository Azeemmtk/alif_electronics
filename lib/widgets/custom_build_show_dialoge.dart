import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_button.dart';

Future<bool?> custombuildShowDialog({
  required BuildContext context,
  required String mainText,
  required String subText,
  required String dataText,
  required String btnText,
  required Function() confirmAction,
}) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.blue[50],
      title: Text(mainText),
      content: SizedBox(
        height: 60.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subText,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              '$dataText ?',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      actions: [
        SizedBox(
          width: 120.w,
          child: CustomButton(
            text: 'Cancel',
            onTap: () {
              Navigator.pop(context, false);
            },
          ),
        ),
        SizedBox(
          width: 120.w,
          child: CustomButton(text: btnText, onTap: confirmAction),
        ),
      ],
    ),
  );
}
