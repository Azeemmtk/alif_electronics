import 'package:alif_electronics/presentation/report/widgets/build_row_details.dart';
import 'package:alif_electronics/provider/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfitOrLoseWidget extends StatelessWidget {
  const ProfitOrLoseWidget({
    super.key,
    required this.totalIncome,
    required this.expenseProvider,
  });

  final double totalIncome;
  final ExpenseProvider expenseProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Total income and expense',
          style: TextStyle(
            fontSize: 19,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: 6.h),
        buildRowDetails(text: 'Total Income', amount: totalIncome),
        SizedBox(height: 3.h),
        buildRowDetails(
            text: 'Total Expense',
            amount: expenseProvider.totalExpenseAmount),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                (totalIncome - expenseProvider.totalExpenseAmount) > 0
                    ? 'Net profit'
                    : 'Net loss',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            Text(' ₹${totalIncome - expenseProvider.totalExpenseAmount} /-',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
          ],
        ),
      ],
    );
  }
}
