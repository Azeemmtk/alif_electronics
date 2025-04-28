import 'package:alif_electronics/db_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:alif_electronics/models/work/work_model.dart';

class WalletProvider extends ChangeNotifier {

  WalletProvider() {
    getAllWork();
  }
  final DbFunctions dbFunctions = DbFunctions();

  int selectedTab = 0;
  List<WorkModel> pendingPayment = [];
  List<WorkModel> completedPayment = [];

  void changeTab(int number) {
    selectedTab = number;
    notifyListeners();
  }

  double get totalPendingAmount {
    final now = DateTime.now();
    final currentMonth = now.month;
    final currentYear = now.year;

    return pendingPayment
        .where(
          (data) =>
      data.expectedDate.month == currentMonth &&
          data.expectedDate.year == currentYear,
    )
        .fold(0.0,
            (sum, work) => sum + (double.tryParse(work.expectedAmount) ?? 0.0));
  }

  void getAllWork() {
    pendingPayment.clear();
    completedPayment.clear();

    for (var work in dbFunctions.getAllWorks()) {
      if (work.paymentStatus == 'Pending' &&
          work.cancellationReason == 'Not Cancelled') {
        pendingPayment.add(work);
      } else if (work.paymentStatus != 'Pending' &&
          work.cancellationReason == 'Not Cancelled') {
        completedPayment.add(work);
      }
    }

    print(
        'Payment categorized: Pending (${pendingPayment.length}), Completed (${completedPayment.length})');
    notifyListeners();
  }
}