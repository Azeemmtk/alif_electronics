import 'package:alif_electronics/models/expense/expense_model.dart';
import 'package:hive/hive.dart';

class ExpenseRepository{

  final _expenseBox = Hive.box<ExpenseModel>('expenses');

  Future<void> addExpense(ExpenseModel expense) async{
    await _expenseBox.add(expense);
  }

  Future<void> updateExpense(int index, ExpenseModel updatedExpense) async {
    await _expenseBox.putAt(index, updatedExpense);
  }

  Future<void> deleteExpense(int index) async {
    await _expenseBox.deleteAt(index);
  }

  List<ExpenseModel> getAllExpenses() {
    return _expenseBox.values.toList();
  }

  double getTotalExpenseAmount() {
    final now = DateTime.now();
    final currentMonth = now.month;
    final currentYear = now.year;

    return _expenseBox.values
        .where(
          (expense) =>
      expense.date.month == currentMonth &&
          expense.date.year == currentYear,
    )
        .fold(0.0, (sum, expense) => sum + expense.amount);
  }


}