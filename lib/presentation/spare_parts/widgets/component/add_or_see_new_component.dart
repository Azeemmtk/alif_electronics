import 'package:alif_electronics/constants/conts.dart';
import 'package:alif_electronics/presentation/spare_parts/screens/add_new_component_screen.dart';
import 'package:alif_electronics/presentation/spare_parts/screens/see_all_component_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddOrSeeNewComponent extends StatelessWidget {
  const AddOrSeeNewComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                  builder: (context) =>
                      AddNewComponentScreen())),
          child: Container(
            height: 45.h,
            width: 180.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.blue[50],
              border: Border.all(color: mainColor),
            ),
            child: const Center(
                child: Text('Add new component',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black))),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                  builder: (context) =>
                  const SeeAllComponentScreen())),
          child: Container(
            height: 45.h,
            width: 180.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.blue[50],
              border: Border.all(color: mainColor),
            ),
            child: const Center(
                child: Text('See all component',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black))),
          ),
        ),
      ],
    );
  }
}
