import 'package:alif_electronics/constants/conts.dart';
import 'package:alif_electronics/models/spare_parts/spare_parts_model.dart';
import 'package:alif_electronics/presentation/spare_parts/widgets/custom_richtext.dart';
import 'package:alif_electronics/presentation/spare_parts/widgets/custom_show_dialog.dart';
import 'package:alif_electronics/provider/spare_parts_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SparePartsSearchScreen extends StatelessWidget {
  const SparePartsSearchScreen({
    super.key,
    required this.datas,
    required this.provider,
  });

  final List<SparepartsModel> datas;
  final SparePartsProvider provider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.separated(
        itemBuilder: (context, index) {
          final data = datas[index];
          return GestureDetector(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: CupertinoColors.systemGrey2),
              ),
              color: Colors.white,
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(9),
                child: Row(
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: Image.asset(data.img!, fit: BoxFit.cover),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${data.category}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17)),
                        CustomRichtext(
                            mainText: 'Model ', boldText: data.model),
                        CustomRichtext(
                            mainText: 'Count ',
                            boldText: data.count.toString()),
                      ],
                    ),
                    Expanded(child: SizedBox()),
                    InkWell(
                      onTap: () => CustomShowDialog(
                        context: context,
                        data: data,
                        increaseSparePartCount: provider.increaseSparePartCount,
                      ),
                      child: Container(
                        height: 35.h,
                        width: 110.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.blue[50],
                          border: Border.all(color: mainColor),
                        ),
                        child: Center(
                            child: Text('Update count',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.black))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 10.h),
        itemCount: datas.length,
      ),
    );
  }
}