import 'package:alif_electronics/presentation/spare_parts/widgets/spare_parts/spare_parts_extra_formate.dart';
import 'package:alif_electronics/presentation/spare_parts/widgets/spare_parts/spare_parts_screen_build_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alif_electronics/models/spare_parts/spare_parts_model.dart';
import 'package:alif_electronics/provider/spare_parts_provider.dart';
import 'package:alif_electronics/presentation/spare_parts/widgets/custom_richtext.dart';

GestureDetector SparePartsCard(SparePartsProvider provider, int index,
    SparepartsModel data, Map<String, String> categoryProps) {
  return GestureDetector(
    onTap: () {
      provider.selectItem(index);
    },
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: CupertinoColors.systemGrey2),
      ),
      color: Colors.white,
      elevation: 6,
      child: Padding(
        padding: EdgeInsets.all(9.r),
        child: Row(
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: SparePartsBuildImage(provider, data),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${data.category} ${data.model}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      if (data.count < 1)
                        const Text(
                          'Out of Stock',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                    ],
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
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
