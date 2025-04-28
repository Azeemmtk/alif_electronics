import 'package:alif_electronics/presentation/Expense/widgets/select_date.dart';
import 'package:alif_electronics/provider/expense_provider.dart';
import 'package:alif_electronics/widgets/custom_appbar.dart';
import 'package:alif_electronics/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:alif_electronics/widgets/custom_textfiled.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    return Scaffold(
      appBar: customAppbar(
          context: context, icon: Icons.arrow_back, text: 'Add Expense'),
      body: Padding(
        padding: EdgeInsets.all(13.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40.h,
            ),
            const Text(
              'Note',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            CustomTextfiled(
              control: expenseProvider.noteController,
              isExpand: true,
              hint: 'Details...',
            ),
            SizedBox(
              height: 20.h,
            ),
            const Text(
              'Enter amount',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            CustomTextfiled(
              control: expenseProvider.amountController,
              isNum: true,
              hint: 'Enter amount',
            ),
            SizedBox(
              height: 25.h,
            ),
            Row(
              children: [
                const Text(
                  'Expected Date',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                GestureDetector(
                  onTap: () {
                    expenseProvider.selectDate(context);
                  },
                  child: SelectDate(expenseProvider: expenseProvider),
                ),
              ],
            ),
            SizedBox(
              height: 40.h,
            ),
            CustomButton(
              text: 'Add Expense',
              onTap: () {
                expenseProvider.addExpense();
              },
            )
          ],
        ),
      ),
    );
  }
}