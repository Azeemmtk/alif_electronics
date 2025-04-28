import 'package:flutter/material.dart';
import 'package:alif_electronics/constants/conts.dart';

AppBar customAppbar({
  required BuildContext context,
  required IconData icon,
  required String text,
  Function()? navigation,
  Widget? edit = const SizedBox(),
}) {
  return AppBar(
    backgroundColor: mainColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(15),
      ),
    ),
    title: Row(
      children: [
        // SizedBox(
        //   width: 60.w,
        // ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
    leading: IconButton(
      onPressed: navigation ??
          () {
            Navigator.pop(context);
          },
      icon: Icon(
        icon,
        size: 29,
        color: Colors.white,
      ),
    ),
    actions: [edit!],
  );
}
