import 'package:alif_electronics/models/expense/expense_model.dart';
import 'package:alif_electronics/db_functions.dart';
import 'package:flutter/material.dart';

class ExpenseProvider extends ChangeNotifier {
  DateTime? selectedDate;
  final DbFunctions dbFunctions = DbFunctions();
  TextEditingController noteController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      notifyListeners();
    }
  }

  Future<void> addExpense() async {
    if (noteController.text.isEmpty ||
        amountController.text.isEmpty ||
        selectedDate == null) {
      return;
    }

    final expense = ExpenseModel(
      note: noteController.text,
      amount: double.parse(amountController.text),
      date: selectedDate!,
    );

    await dbFunctions.addExpense(expense);
    print('======data added to hive');
    clearFields();
    notifyListeners();
  }

  Future<void> updateExpense(int index, ExpenseModel updatedExpense) async {
    await dbFunctions.updateExpense(index, updatedExpense);
    notifyListeners();
  }

  Future<void> deleteExpense(int index) async {
    await dbFunctions.deleteExpense(index);
    notifyListeners();
  }

  List<ExpenseModel> getAllExpenses() {
    return dbFunctions.getAllExpenses();
  }

  double get totalExpenseAmount {
    return dbFunctions.getTotalExpenseAmount();
  }

  void clearFields() {
    noteController.clear();
    amountController.clear();
    selectedDate = null;
    notifyListeners();
  }
}