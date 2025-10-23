import 'package:alif_electronics/presentation/Expense/expense_screen.dart';
import 'package:alif_electronics/presentation/Profile_screen.dart';
import 'package:alif_electronics/presentation/help_screen.dart';
import 'package:alif_electronics/presentation/report/monthly_report_screen.dart';
import 'package:alif_electronics/presentation/terms_screen.dart';
import 'package:alif_electronics/presentation/work/screens/cancelled_work_screen.dart';
import 'package:alif_electronics/provider/spare_parts_provider.dart';
import 'package:alif_electronics/widgets/settings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:alif_electronics/presentation/spare_parts/screens/add_Spare_parts_screen.dart';
import 'package:alif_electronics/presentation/spare_parts/screens/spare_parts_screen.dart';
import 'package:alif_electronics/presentation/used_tv/Add_usedtv_screen.dart';
import 'package:alif_electronics/presentation/work/screens/add_work_screen.dart';
import 'package:alif_electronics/constants/conts.dart';

Drawer mainDrawer(BuildContext context) {
  final provider = Provider.of<SparePartsProvider>(context);
  return Drawer(
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(
              top: 50, bottom: 20),
          decoration: const BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.only(
                // bottomLeft: Radius.circular(20),
                // bottomRight: Radius.circular(20),
                ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/appLogo.png',
                  height: 35,
                ),
                const SizedBox(height: 10),
                const Text(
                  'ALIF ELECTRONICS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                leading: const Icon(Icons.home_filled, color: mainColor),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.event_note_sharp, color: mainColor),
                title: const Text('Expense'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => const ExpenseScreen(),
                      ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.build_outlined, color: mainColor),
                title: const Text('Spare parts'),
                onTap: () {
                  provider.loadAllData();
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => const SparePartsScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.add_chart, color: mainColor),
                title: const Text('Add spare parts'),
                onTap: () {
                  provider.setIsSearching(false);
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => const AddSparePartsScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.work_outline, color: mainColor),
                title: const Text('Add Work'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => AddWorkScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.tv, color: mainColor),
                title: const Text('Add Used TV'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => AddUsedtvScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel_outlined, color: mainColor),
                title: const Text('Cancelled works'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => const CancelledWorkScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.attach_money, color: mainColor),
                title: const Text('Monthly report'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => const MonthlyReportScreen(),
                      ));
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.person_2_outlined, color: mainColor),
                title: const Text('Profile'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
              ),

              Settings(),
            ],
          ),
        )
      ],
    ),
  );
}