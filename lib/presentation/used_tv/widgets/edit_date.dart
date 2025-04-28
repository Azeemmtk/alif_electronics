import 'package:alif_electronics/presentation/used_tv/edit_usedtv_screen.dart';
import 'package:alif_electronics/provider/usedtv_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditDate extends StatelessWidget {
  const EditDate({
    super.key,
    required this.provider,
    required this.widget,
  });

  final UsedtvProvider provider;
  final EditUsedtvScreen widget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => provider.selectDate(context),
      child: Container(
        width: double.infinity,
        padding:
        EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.r),
          color: Colors.blue[50],
        ),
        child: Text(
          provider.selectedDate == null
              ? '${widget.usedTv.purchaseDate.day}/${widget.usedTv.purchaseDate.month}/${widget.usedTv.purchaseDate.year}'
              : '${provider.selectedDate!.day}/${provider.selectedDate!.month}/${provider.selectedDate!.year}',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
