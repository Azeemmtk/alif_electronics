import 'dart:io';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:alif_electronics/constants/conts.dart';
import 'package:alif_electronics/presentation/work/widgets/status_change_cancel_button.dart';
import 'package:alif_electronics/presentation/work/widgets/view_tv_details.dart';
import 'package:alif_electronics/provider/work_provider.dart';
import 'package:alif_electronics/presentation/main_screen.dart';
import 'package:alif_electronics/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:alif_electronics/provider/home_provider.dart';
import 'package:alif_electronics/provider/wallet_provider.dart';
import 'package:alif_electronics/widgets/custom_button.dart';
import 'package:alif_electronics/presentation/work/widgets/customer_tv_details_column.dart';
import 'package:alif_electronics/presentation/work/screens/edit_work_screen.dart';

class WorkDetailsScreen extends StatelessWidget {
  const WorkDetailsScreen({
    super.key,
    required this.selectedTab,
    required this.index,
  });

  final int selectedTab;
  final int index;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WorkProvider>(context);
    final walletProvider = Provider.of<WalletProvider>(context);
    final homeProvider = Provider.of<HomeProvider>(context);
    final data = provider.selectedTab == 0
        ? provider.pendingWork[index]
        : provider.selectedTab == 1
        ? provider.inProgressWork[index]
        : provider.completedWork[index];
    return Scaffold(
      appBar: customAppbar(
          context: context,
          icon: Icons.arrow_back,
          text: 'Work details',
          edit: selectedTab != 2
              ? IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => EditWorkScreen(
                    works: data,
                    index: index,
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          )
              : const SizedBox()),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10.h),
              Text(
                data.status,
                style: TextStyle(
                  color: selectedTab == 0
                      ? const Color(0xFFFB0069)
                      : selectedTab == 1
                      ? const Color(0xFFA3A539)
                      : const Color(0xFF326732),
                  fontSize: 19,
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                  height: MediaQuery.of(context).size.width<=394? 250.h: 400.h,
                width: 350.w,
                decoration: BoxDecoration(
                  border: Border.all(color: mainColor),
                  borderRadius: BorderRadius.circular(11.r),
                ),
                child: Hero(
                  tag: 'image-${data.workId}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: kIsWeb
                        ? Image.memory(
                      Uint8List.fromList(data.imagePath as List<int>),
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) =>
                          Image.asset(
                            'assets/images/imglogo.png',
                            fit: BoxFit.fill,
                          ),
                    )
                        : Image.file(
                      File(data.imagePath as String),
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) =>
                          Image.asset(
                            'assets/images/imglogo.png',
                            fit: BoxFit.fill,
                          ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Work Id: ${data.workId}',
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      ViewTvDetails(data: data),
                      SizedBox(height: 30.h),
                      const Text(
                        'Customer details',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Padding(
                        padding: EdgeInsets.only(left: 10.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomerTVDetailsColumn(
                              data: data,
                              head: 'Name',
                              value: data.customerName,
                            ),
                            CustomerTVDetailsColumn(
                              data: data,
                              head: 'Phone number',
                              value: data.phoneNumber,
                            ),
                          ],
                        ),
                      ),
                      selectedTab == 2
                          ? CustomButton(
                        text: 'Complete payment',
                        onTap: () {
                          print('Go to payment');
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) => const MainScreen(),
                            ),
                                (route) => false,
                          );
                          homeProvider.changeSelectedIndex(3);
                        },
                      )
                          : StatusChangeCancelButton(
                          provider: provider,
                          data: data,
                          selectedTab: selectedTab,
                          walletProvider: walletProvider)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}