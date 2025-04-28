import 'package:alif_electronics/presentation/wallet/widgets/custom_wallet_tab.dart';
import 'package:alif_electronics/presentation/wallet/widgets/wallet_list.dart';
import 'package:alif_electronics/provider/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:alif_electronics/constants/conts.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WalletProvider>(context);
    final datas = provider.selectedTab == 0
        ? provider.pendingPayment
        : provider.completedPayment;
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! < 0) {
          if (provider.selectedTab == 0) {
            provider.changeTab(1);
          }
        } else if (details.primaryVelocity! > 0) {
          if (provider.selectedTab == 1) {
            provider.changeTab(0);
          }
        }
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.r, right: 15.r, top: 15.r),
            child: Container(
              height: 45.h,
              width: MediaQuery.of(context).size.width - 30.w,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(50),
                ),
                border: Border.all(color: Colors.black),
              ),
              child: Row(
                children: [
                  CustomWalletTabs(
                    provider: provider,
                    head: 'Pending payment\'s',
                    color: const Color(0xFFFB0069),
                    tab: 0,
                  ),
                  CustomWalletTabs(
                    head: 'Completed payment\'s',
                    provider: provider,
                    tab: 1,
                    color: const Color(0xFF326732),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          datas.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width<=394? 70.h: 18.h,
                      ),
                      Lottie.asset('assets/lottie/nodata.json'),
                      Text(
                        provider.selectedTab == 0
                            ? 'Works not completed'
                            : 'Payment not completed',
                        style: const TextStyle(
                          fontSize: 18,
                          color: mainColor,
                        ),
                      )
                    ],
                  ),
                )
              : WalletList(
                  datas: datas,
                ),
        ],
      ),
    );
  }
}
