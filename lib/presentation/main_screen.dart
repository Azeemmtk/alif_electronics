import 'package:alif_electronics/provider/home_provider.dart';
import 'package:alif_electronics/constants/conts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:alif_electronics/presentation/used_tv/Add_usedtv_screen.dart';
import 'package:alif_electronics/presentation/work/screens/add_work_screen.dart';
import 'package:alif_electronics/widgets/main_drawer.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: provider.selectedIndex == 0
                ? const Radius.circular(0)
                : const Radius.circular(15),
          ),
        ),
        title: provider.selectedIndex == 0
            ? Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        provider.pageName[provider.selectedIndex],
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 56.w,
                  )
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        provider.pageName[provider.selectedIndex],
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 56.w,
                  )
                ],
              ),
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              size: 29,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: provider.screens[provider.selectedIndex],
      drawer: mainDrawer(context),
      floatingActionButton:
          provider.selectedIndex == 1 || provider.selectedIndex == 2
              ? FloatingActionButton(
                  backgroundColor: FABColor,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => provider.selectedIndex == 1
                            ? AddWorkScreen()
                            : AddUsedtvScreen(),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 50,
                  ),
                )
              : const SizedBox(),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        child: BottomNavigationBar(
          onTap: (value) {
            provider.changeSelectedIndex(value);
          },
          currentIndex: provider.selectedIndex,
          backgroundColor: mainColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: const Color(0xFF8AAFC8),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Work'),
            BottomNavigationBarItem(icon: Icon(Icons.tv), label: 'Used TV\'s '),
            BottomNavigationBarItem(icon: Icon(Icons.wallet), label: 'Wallet'),
            BottomNavigationBarItem(
                icon: Icon(Icons.insert_chart_rounded), label: 'Report'),
          ],
        ),
      ),
    );
  }
}
