import 'package:alif_electronics/constants/conts.dart';
import 'package:alif_electronics/presentation/spare_parts/widgets/spare_parts_expanded_card.dart';
import 'package:alif_electronics/provider/spare_parts_provider.dart';
import 'package:alif_electronics/presentation/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:alif_electronics/models/spare_parts/spare_parts_model.dart';
import 'package:alif_electronics/presentation/spare_parts/screens/add_Spare_parts_screen.dart';
import 'package:alif_electronics/widgets/custom_appbar.dart';
import 'package:alif_electronics/widgets/custom_textfiled.dart';
import 'package:alif_electronics/presentation/spare_parts/widgets/custom_richtext.dart';
import 'package:alif_electronics/presentation/spare_parts/widgets/spare_parts/spare_parts_expanded_card.dart';
import 'package:alif_electronics/presentation/spare_parts/widgets/spare_parts/spare_parts_extra_formate.dart';
import 'package:alif_electronics/presentation/spare_parts/widgets/spare_parts/spare_parts_screen_build_image.dart';
import 'package:alif_electronics/presentation/spare_parts/screens/edit_spare_parts_screen.dart';

class SparePartsScreen extends StatelessWidget {
  const SparePartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SparePartsProvider>(context);
    final List<SparepartsModel> datas = provider.filteredSpareParts;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute<void>(builder: (context) => const MainScreen()),
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        appBar: customAppbar(
          context: context,
          icon: Icons.arrow_back,
          text: 'Spare parts',
          navigation: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute<void>(builder: (context) => const MainScreen()),
              (route) => false,
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: FABColor,
          onPressed: () {
            provider.setIsSearching(false);
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                  builder: (context) => const AddSparePartsScreen()),
            );
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 50,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(12.r),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Row(
                children: [
                  SizedBox(
                    height: 55.h,
                    width: 370.w,
                    child: CustomTextfiled(
                      hint: 'Search parts...',
                      preficon: Icons.search,
                      onChanged: (value) {
                        provider.searchSpareParts(value);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              datas.isEmpty
                  ? Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.width<=394? 70.h: 18.h,
                          ),
                          Lottie.asset('assets/lottie/nodata.json'),
                          const Text(
                            'No spare parts available',
                            style: TextStyle(
                              fontSize: 18,
                              color: mainColor,
                            ),
                          )
                        ],
                      ),
                    )
                  : Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final data = datas[index];
                          final categoryProps = provider
                                  .customCategories[data.category] ??
                              {'extra1': 'Property 1', 'extra2': 'Property 2'};

                          return index == provider.selectedIndex
                              ? SparePartsExpandedCard(
                                  provider: provider,
                                  data: data,
                                  categoryProps: categoryProps)
                              : SparePartsCard(
                                  provider,
                                  index,
                                  data,
                                  categoryProps,
                                );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10.h),
                        itemCount: datas.length,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}