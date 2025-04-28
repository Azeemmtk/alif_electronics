import 'package:alif_electronics/provider/work_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectWorkDate extends StatelessWidget {
  const SelectWorkDate({
    super.key,
    required this.workProvider,
  });

  final WorkProvider workProvider;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        workProvider.selectDate(context);
      },
      child: Container(
        height: 30.h,
        width: 113,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(
            color: CupertinoColors.systemGrey,
          ),
          color: Colors.blue[50],
        ),
        child: Center(
          child: workProvider.selectedDate == null
              ? const Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.date_range, size: 19),
              Text(
                'Select date',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ],
          )
              : Text(
            '${workProvider.selectedDate!.day}/${workProvider.selectedDate!.month}/${workProvider.selectedDate!.year}',
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}