import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alif_electronics/provider/wallet_provider.dart';
import 'package:alif_electronics/constants/conts.dart';

class CustomWalletTabs extends StatelessWidget {
  const CustomWalletTabs({
    super.key,
    required this.provider,
    required this.tab,
    required this.color,
    required this.head,
  });

  final WalletProvider provider;
  final int tab;
  final Color color;
  final String head;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          provider.changeTab(tab);
        },
        child: Container(
          height: 45.h,
          decoration: BoxDecoration(
            color: provider.selectedTab == tab ? logoColor : mainColor,
            borderRadius: tab == 0
                ? const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
          ),
          child: Center(
            child: Text(
              head,
              style: TextStyle(
                color: provider.selectedTab == tab ? color : Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
