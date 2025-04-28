import 'package:alif_electronics/constants/conts.dart';
import 'package:alif_electronics/models/spare_parts/spare_parts_model.dart';
import 'package:alif_electronics/presentation/spare_parts/screens/edit_spare_parts_screen.dart';
import 'package:alif_electronics/presentation/spare_parts/widgets/custom_richtext.dart';
import 'package:alif_electronics/presentation/spare_parts/widgets/spare_parts/spare_parts_extra_formate.dart';
import 'package:alif_electronics/presentation/spare_parts/widgets/spare_parts/spare_parts_screen_build_image.dart';
import 'package:alif_electronics/provider/spare_parts_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SparePartsExpandedCard extends StatelessWidget {
  const SparePartsExpandedCard({
    super.key,
    required this.provider,
    required this.data,
    required this.categoryProps,
  });

  final SparePartsProvider provider;
  final SparepartsModel data;
  final Map<String, String> categoryProps;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: CupertinoColors.systemGrey2),
      ),
      color: Colors.white,
      elevation: 6,
      child: Padding(
        padding: EdgeInsets.all(9.r),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 130,
                  width: 130,
                  child: SparePartsBuildImage(provider, data),
                ),
                SizedBox(height: 10.h),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => EditSparePartsScreen(data: data),
                      ),
                    );
                  },
                  child: Container(
                    height: 30.h,
                    width: 140,
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Edit',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        const Icon(Icons.edit, color: Colors.white, size: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Wrap(
                direction: Axis.vertical,
                spacing: 5.h,
                children: [
                  Text(
                    '${data.category} ${data.model}',
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  CustomRichtext(
                    mainText: '${categoryProps['extra1']}: ',
                    boldText:
                    formatExtra(data.category, data.extra1, isExtra1: true),
                  ),
                  CustomRichtext(
                    mainText: '${categoryProps['extra2']}: ',
                    boldText: formatExtra(data.category, data.extra2,
                        isExtra1: false),
                  ),
                  CustomRichtext(
                    mainText: 'Price: ',
                    boldText: '₹${data.price}',
                  ),
                  CustomRichtext(
                    mainText: 'Location: ',
                    boldText: data.location,
                  ),
                  CustomRichtext(
                    mainText: 'Number of stock: ',
                    boldText: data.count.toString(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
