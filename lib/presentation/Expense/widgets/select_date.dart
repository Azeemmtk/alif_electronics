import 'package:alif_electronics/provider/expense_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectDate extends StatelessWidget {
  const SelectDate({
    super.key,
    required this.expenseProvider,
  });

  final ExpenseProvider expenseProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: expenseProvider.selectedDate == null
            ? const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.date_range,
              size: 19,
            ),
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
          '${expenseProvider.selectedDate!.day}/${expenseProvider.selectedDate!.month}/${expenseProvider.selectedDate!.year}',
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
