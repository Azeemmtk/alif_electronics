import 'package:alif_electronics/widgets/shop_owner_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:alif_electronics/constants/conts.dart';
import 'package:alif_electronics/provider/expense_provider.dart';
import 'package:alif_electronics/provider/home_provider.dart';
import 'package:alif_electronics/provider/usedtv_provider.dart';
import 'package:alif_electronics/provider/work_provider.dart';
import 'package:alif_electronics/widgets/profile_income_details.dart';
import 'package:alif_electronics/widgets/profile_work_details.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    final workProvider = Provider.of<WorkProvider>(context);
    final usedTVProvider = Provider.of<UsedtvProvider>(context);
    final totalIncome =
        usedTVProvider.totalSoldTvMarketPrice + workProvider.totalFinalAmount;
    final profitOrLose = (totalIncome - expenseProvider.totalExpenseAmount);

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'ALIF ELECTRONICS',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: mainColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 29,
            color: Colors.white,
          ),
        ),
        actions: const [
          SizedBox(width: 50,),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ShopOwnerDetails(homeProvider: homeProvider),
            Padding(
              padding: EdgeInsets.all(10.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Card(
                      color: Colors.blue[50],
                      child: Padding(
                        padding: EdgeInsets.all(10.r),
                        child: SizedBox(
                            // height: MediaQuery.of(context).size.height / 2.1,
                            width: MediaQuery.of(context).size.height,
                            child: Column(
                              children: [
                                ProfileWorkDetails(workProvider: workProvider),
                                const Divider(),
                                ProfileIncomeDetails(totalIncome: totalIncome, profitOrLose: profitOrLose)
                              ],
                            )),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}