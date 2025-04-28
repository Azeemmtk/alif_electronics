import 'package:alif_electronics/constants/conts.dart';
import 'package:alif_electronics/presentation/home/widgets/pending_payment_section.dart';
import 'package:alif_electronics/presentation/home/widgets/used_tv_section.dart';
import 'package:alif_electronics/presentation/home/widgets/work_count_card.dart';
import 'package:alif_electronics/provider/home_provider.dart';
import 'package:alif_electronics/provider/usedtv_provider.dart';
import 'package:alif_electronics/provider/work_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:alif_electronics/provider/wallet_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final workProvider = Provider.of<WorkProvider>(context);
    final homeProvider = Provider.of<HomeProvider>(context);
    final walletProvider = Provider.of<WalletProvider>(context);
    final usedTVProvider = Provider.of<UsedtvProvider>(context);
    final pendingData = walletProvider.pendingPayment;
    final usedTVData = usedTVProvider.availableUsedTv;
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width<=394? 210.h: 250.h,
                  width: double.infinity,
                ),
                Container(
                  height: 110.h,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100),
                    ),
                  ),
                ),
                Positioned(
                  top: 20.h,
                  left: 10.w,
                  child: WorkCountCard(
                    workProvider: workProvider,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PendingPaymentSection(homeProvider: homeProvider, pendingData: pendingData),
                   SizedBox(
                    height: 10.h,
                  ),
                  UsedTvSection(usedTVData: usedTVData),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}