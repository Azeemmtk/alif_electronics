import 'package:alif_electronics/models/expense/expense_model.dart';
import 'package:alif_electronics/presentation/Expense/widgets/select_date.dart';
import 'package:alif_electronics/widgets/custom_appbar.dart';
import 'package:alif_electronics/widgets/customsnackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:alif_electronics/provider/expense_provider.dart';
import 'package:alif_electronics/widgets/custom_button.dart';
import 'package:alif_electronics/widgets/custom_textfiled.dart';

class EditExpenseScreen extends StatefulWidget {
  const EditExpenseScreen({super.key, required this.index});
  final int index;

  @override
  State<EditExpenseScreen> createState() => _EditExpenseScreenState();
}

class _EditExpenseScreenState extends State<EditExpenseScreen> {
  @override
  void initState() {
    super.initState();
    final expenseProvider =
        Provider.of<ExpenseProvider>(context, listen: false);
    final data = expenseProvider.getAllExpenses()[widget.index];
    expenseProvider.noteController.text = data.note;
    expenseProvider.amountController.text = data.amount.toString();
    expenseProvider.selectedDate = data.date;
  }

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    return Scaffold(
      appBar: customAppbar(
          context: context, icon: Icons.arrow_back, text: 'Edit Expense'),
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
              hint: 'Details...',
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
              text: 'Edit Expense',
              onTap: () async {
                final newData = ExpenseModel(
                  note: expenseProvider.noteController.text,
                  amount:
                      double.tryParse(expenseProvider.amountController.text)!,
                  date: expenseProvider.selectedDate!,
                );
                await expenseProvider.updateExpense(widget.index, newData);
                  customSnackbar(
                      context: context, Message: 'Expense updated successfully');
                  Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}