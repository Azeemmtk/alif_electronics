import 'package:alif_electronics/constants/conts.dart';
import 'package:alif_electronics/presentation/Expense/add_expense_screen.dart';
import 'package:alif_electronics/presentation/Expense/edit_expense_screen.dart';
import 'package:alif_electronics/provider/expense_provider.dart';
import 'package:alif_electronics/widgets/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:alif_electronics/models/expense/expense_model.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    final List<ExpenseModel> datas = expenseProvider.getAllExpenses();
    return Scaffold(
      appBar: customAppbar(
          context: context, icon: Icons.arrow_back, text: 'Expenses'),
      floatingActionButton: FloatingActionButton(
        backgroundColor: FABColor,
        onPressed: () {
          expenseProvider.clearFields();
          Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const AddExpenseScreen(),
              ));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 50,
        ),
      ),
      body: datas.isEmpty
          ? Center(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width<=394? 70.h: 18.h,
                  ),
                  Lottie.asset('assets/lottie/nodata.json'),
                  const Text(
                    'No expenses',
                    style: TextStyle(
                      fontSize: 18,
                      color: mainColor,
                    ),
                  )
                ],
              ),
            )
          : Padding(
              padding: EdgeInsets.all(13.r),
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final data = datas[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: CupertinoColors.systemGrey2),
                      ),
                      color: Colors.white,
                      elevation: 6,
                      child: Padding(
                        padding: EdgeInsets.all(13.r),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.note,
                                  style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '₹: ${data.amount}/-',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (context) =>
                                              EditExpenseScreen(
                                            index: index,
                                          ),
                                        ));
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: mainColor,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    expenseProvider.deleteExpense(index);
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.delete,
                                    color: Colors.redAccent,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 5.h,
                    );
                  },
                  itemCount: datas.length),
            ),
    );
  }
}
