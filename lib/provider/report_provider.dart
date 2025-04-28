import 'package:flutter/material.dart';
import 'package:alif_electronics/models/used_tv/used_tv_model.dart';
import 'package:alif_electronics/models/work/work_model.dart';
import 'package:alif_electronics/provider/usedtv_provider.dart';
import 'package:alif_electronics/provider/wallet_provider.dart';
import 'package:provider/provider.dart';

class ReportProvider extends ChangeNotifier {
  int selectedTab = 0;
  DateTime? selectedFromDate;
  DateTime? selectedToDate;

  void changeTab(int number) {
    selectedTab = number;
    notifyListeners();
  }

  Future<void> selectDate({
    required BuildContext context,
    required bool isFrom,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isFrom
          ? selectedFromDate ?? DateTime.now()
          : selectedToDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      if (isFrom && picked != selectedFromDate) {
        selectedFromDate = picked;
      } else if (!isFrom && picked != selectedToDate) {
        selectedToDate = picked;
      }
      notifyListeners();
    }
  }

  List<UsedTvModel> getFilteredSoldUsedTv(BuildContext context) {
    final usedTVProvider = Provider.of<UsedtvProvider>(context, listen: false);
    if (selectedFromDate == null || selectedToDate == null) {
      return usedTVProvider.soldUsedTv;
    }
    return usedTVProvider.soldUsedTv.where((tv) {
      return tv.soldDate!
              .isAfter(selectedFromDate!.subtract(const Duration(days: 1))) &&
          tv.soldDate!.isBefore(selectedToDate!.add(const Duration(days: 1)));
    }).toList();
  }

  List<WorkModel> getFilteredCompletedPayments(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);
    if (selectedFromDate == null || selectedToDate == null) {
      return walletProvider
          .completedPayment;
    }
    return walletProvider.completedPayment.where((work) {
      return work.expectedDate
              .isAfter(selectedFromDate!.subtract(const Duration(days: 1))) &&
          work.expectedDate.isBefore(selectedToDate!.add(const Duration(days: 1)));
    }).toList();
  }

  double getTotalSoldTvIncome(BuildContext context) {
    final filteredSoldTvs = getFilteredSoldUsedTv(context);
    return filteredSoldTvs.fold(0.0, (sum, tv) => sum + tv.marketPrice);
  }

  double getTotalWorkIncome(BuildContext context) {
    final filteredPayments = getFilteredCompletedPayments(context);
    return filteredPayments.fold(
        0.0, (sum, work) => sum + (work.finalAmount ?? 0.0));
  }

  double getTotalIncome(BuildContext context) {
    return getTotalSoldTvIncome(context) + getTotalWorkIncome(context);
  }
}
