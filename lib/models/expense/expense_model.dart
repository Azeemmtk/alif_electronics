import 'package:hive/hive.dart';
part 'expense_model.g.dart';

@HiveType(typeId: 4)
class ExpenseModel {
  @HiveField(0)
  String note;

  @HiveField(1)
  double amount;

  @HiveField(2)
  DateTime date;

  ExpenseModel({
    required this.note,
    required this.amount,
    required this.date,
  });
}
