import 'package:alif_electronics/presentation/report/widgets/build_row_details.dart';
import 'package:alif_electronics/presentation/report/widgets/generate_montly_report_pdf.dart';
import 'package:alif_electronics/presentation/report/widgets/payment_report.dart';
import 'package:alif_electronics/presentation/report/widgets/profit_or_lose_widget.dart';
import 'package:alif_electronics/presentation/report/widgets/repair_summery.dart';
import 'package:alif_electronics/presentation/report/widgets/spare_parts_report.dart';
import 'package:alif_electronics/presentation/report/widgets/used_tv_report.dart';
import 'package:alif_electronics/provider/expense_provider.dart';
import 'package:alif_electronics/provider/spare_parts_provider.dart';
import 'package:alif_electronics/provider/usedtv_provider.dart';
import 'package:alif_electronics/provider/wallet_provider.dart';
import 'package:alif_electronics/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:open_file/open_file.dart';
import 'package:alif_electronics/provider/work_provider.dart';
import 'package:alif_electronics/widgets/custom_button.dart';
import 'package:alif_electronics/widgets/customsnackbar.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MonthlyReportScreen extends StatelessWidget {
  const MonthlyReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    final sparePartsProvider = Provider.of<SparePartsProvider>(context);
    final workProvider = Provider.of<WorkProvider>(context);
    final usedTVProvider = Provider.of<UsedtvProvider>(context);
    final totalIncome =
        usedTVProvider.totalSoldTvMarketPrice + workProvider.totalFinalAmount;

    return Scaffold(
      appBar: customAppbar(
          context: context, icon: Icons.arrow_back, text: 'Monthly report'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfitOrLoseWidget(
                  totalIncome: totalIncome, expenseProvider: expenseProvider),
              SizedBox(height: 25.h),
              RepairSummery(workProvider: workProvider),
              SizedBox(height: 25.h),
              PaymentReport(
                  workProvider: workProvider, walletProvider: walletProvider),
              SizedBox(height: 25.h),
              SparePartsReport(
                  sparePartsProvider: sparePartsProvider,
                  workProvider: workProvider),
              SizedBox(height: 25.h),
              UsedTvReport(usedTVProvider: usedTVProvider),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Income from used TV',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  Text(' ₹ ${usedTVProvider.totalSoldTvMarketPrice}/-',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                ],
              ),
              SizedBox(height: 15.h),
              CustomButton(
                text: 'Save as pdf',
                icon: FontAwesomeIcons.solidFilePdf,
                onTap: () async {
                  try {
                    final pdfGenerator = GenerateMonthlyReportPdf();
                    final result = await pdfGenerator.generateAndSavePdf(
                      totalIncome: totalIncome,
                      totalExpense: expenseProvider.totalExpenseAmount,
                      netProfit: totalIncome - expenseProvider.totalExpenseAmount,
                      completedWorks:
                      workProvider.currentMonthCompletedWorkCount.toDouble(),
                      pendingWorks:
                      workProvider.currentMonthPendingWorkCount.toDouble(),
                      inProgressWorks:
                      workProvider.currentMonthInProgressWorkCount.toDouble(),
                      cancelledWorks:
                      workProvider.currentMonthCancelledWorkCount.toDouble(),
                      totalReceived: workProvider.totalFinalAmount,
                      pendingAmount: walletProvider.totalPendingAmount,
                      purchasedExpense: sparePartsProvider.totalSparePartsValue,
                      totalUsed: workProvider.totalAllSparePartsUsedValue,
                      totalTvSold:
                      usedTVProvider.currentMonthsoldtvcount.toDouble(),
                      availableTv:
                      usedTVProvider.availableUsedTv.length.toDouble(),
                      tvIncome: usedTVProvider.totalSoldTvMarketPrice,
                    );
                    if (kIsWeb) {
                      // Web: PDF is downloaded via browser
                      customSnackbar(
                          context: context, Message: 'PDF downloaded');
                    } else {
                      // Mobile: Open the saved PDF
                      final openResult = await OpenFile.open(result);
                      if (openResult.type != ResultType.done) {
                        customSnackbar(
                            context: context,
                            Message: 'Failed to open PDF: ${openResult.message}');
                      } else {
                        customSnackbar(
                            context: context, Message: 'PDF saved and opened');
                      }
                    }
                  } catch (e) {
                    print('Error generating PDF: $e');
                    customSnackbar(
                        context: context,
                        Message: 'Failed to generate PDF: $e');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}