import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alif_electronics/constants/conts.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.text, required this.onTap, this.icon});

  String text;
  Function()? onTap;
  IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 45.h,
        width: 250.w,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                7.r,
              ),
              side: BorderSide(
                color: mainColor,
                width: 1
              ),
            ),
          ),
          onPressed: onTap,
          child: icon == null
              ? Text(
                  text,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: mainColor,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: mainColor,
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Icon(
                      icon,
                      color: Colors.red,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
