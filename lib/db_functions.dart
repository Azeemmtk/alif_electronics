import 'package:alif_electronics/models/expense/expense_model.dart';
import 'package:alif_electronics/models/spare_parts/spare_parts_model.dart';
import 'package:alif_electronics/models/spare_parts_used/spare_parts_used.dart';
import 'package:alif_electronics/models/used_tv/used_tv_model.dart';
import 'package:alif_electronics/models/work/work_model.dart';
import 'package:hive/hive.dart';

class DbFunctions {
  final Box<UsedTvModel> _usedTvBox = Hive.box<UsedTvModel>('used_tv_box');
  final Box<ExpenseModel> _expenseBox = Hive.box<ExpenseModel>('expenses');
  final Box<WorkModel> _workBox = Hive.box<WorkModel>('work_box');
  final Box<SparePartUsage> _sparePartsBox = Hive.box<SparePartUsage>('spare_parts_box');
  final Box<SparepartsModel> _sparePartsBoxMain = Hive.box<SparepartsModel>('spare_parts');
  final Box<Map> _categoriesBox = Hive.box<Map>('categories');

  // Used TV Database Functions
  Future<void> addUsedTv(UsedTvModel usedTv) async {
    await _usedTvBox.add(usedTv);
  }

  Future<void> updateUsedTv(int index, UsedTvModel updatedTv) async {
    await _usedTvBox.putAt(index, updatedTv);
  }

  Future<void> deleteUsedTv(dynamic key) async {
    await _usedTvBox.delete(key);
  }

  List<UsedTvModel> getAllUsedTvs() {
    return _usedTvBox.values.toList();
  }

  UsedTvModel? getUsedTvByKey(dynamic key) {
    return _usedTvBox.get(key);
  }

  // Expense Database Functions
  Future<void> addExpense(ExpenseModel expense) async {
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

  // Work Database Functions
  Future<void> addWork(WorkModel work) async {
    await _workBox.add(work);
  }

  Future<void> updateWork(int index, WorkModel updatedWork) async {
    await _workBox.putAt(index, updatedWork);
  }

  Future<void> deleteWork(int index) async {
    await _workBox.deleteAt(index);
  }

  List<WorkModel> getAllWorks() {
    return _workBox.values.toList();
  }

  WorkModel? getWorkAtIndex(int index) {
    return _workBox.getAt(index);
  }

  // Spare Parts Usage Database Functions
  Future<void> addSparePartUsage(SparePartUsage usage) async {
    await _sparePartsBox.add(usage);
  }

  List<SparePartUsage> getSparePartsForWork(String workId) {
    return _sparePartsBox.values.where((usage) => usage.workId == workId).toList();
  }

  double getTotalSparePartsUsedValue() {
    return _sparePartsBox.values.fold(
        0.0, (sum, part) => sum + (part.price * part.count) + part.serviceCharge!);
  }

  // Spare Parts (Main) Database Functions
  Future<void> addSparePart(SparepartsModel sparePart, String key) async {
    await _sparePartsBoxMain.put(key, sparePart);
  }

  Future<void> updateSparePart(String key, SparepartsModel updatedSparePart) async {
    await _sparePartsBoxMain.put(key, updatedSparePart);
  }

  Future<void> deleteSparePart(String key) async {
    await _sparePartsBoxMain.delete(key);
  }

  SparepartsModel? getSparePart(String key) {
    return _sparePartsBoxMain.get(key);
  }

  List<SparepartsModel> getAllSpareParts() {
    return _sparePartsBoxMain.values.toList();
  }

  double getTotalSparePartsValue() {
    return _sparePartsBoxMain.values
        .fold(0.0, (sum, part) => sum + (part.price * part.count));
  }

  Stream<BoxEvent> watchSpareParts() {
    return _sparePartsBoxMain.watch();
  }

  // Categories Database Functions
  Future<void> saveCategories(Map<String, Map<String, String>> categories) async {
    await _categoriesBox.put('customCategories', categories);
  }

  Map<String, Map<String, String>>? getCategories() {
    final rawCategories = _categoriesBox.get('customCategories');
    if (rawCategories == null) return null;
    return rawCategories.map((key, value) => MapEntry(
      key as String,
      (value as Map).cast<String, String>(),
    ));
  }
}