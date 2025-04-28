import 'dart:io';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:alif_electronics/constants/conts.dart';
import 'package:alif_electronics/models/work/work_model.dart';
import 'package:alif_electronics/presentation/work/screens/work_details_screen.dart';
import 'package:alif_electronics/provider/work_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkList extends StatelessWidget {
  const WorkList({
    super.key,
    required this.datas,
    required this.provider,
  });

  final List<WorkModel> datas;
  final WorkProvider provider;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        itemBuilder: (context, index) {
          final data = datas[index];
          return GestureDetector(
            onTap: () {
              print(data.status);
              print(data.paymentStatus);
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => WorkDetailsScreen(
                    index: index,
                    selectedTab: provider.selectedTab,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 7,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Card(
                elevation: 6,
                shadowColor: Colors.black,
                color: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    border: Border.all(color: mainColor),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 96,
                        width: 130,
                        child: Hero(
                          tag: 'image-${data.workId}',
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(11.r),
                              bottomLeft: Radius.circular(11.r),
                            ),
                            child: kIsWeb
                                ? (data.imagePath is List<int>
                                ? Image.memory(
                              Uint8List.fromList(data.imagePath as List<int>),
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                    'assets/images/imglogo.png',
                                    fit: BoxFit.fill,
                                  ),
                            )
                                : Image.asset(
                              'assets/images/imglogo.png',
                              fit: BoxFit.fill,
                            ))
                                : (data.imagePath is String && (data.imagePath as String).isNotEmpty
                                ? Image.file(
                              File(data.imagePath as String),
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                    'assets/images/imglogo.png',
                                    fit: BoxFit.fill,
                                  ),
                            )
                                : Image.asset(
                              'assets/images/imglogo.png',
                              fit: BoxFit.fill,
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Brand: ${data.brandName}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Model: ${data.modelNumber}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Issue: ${data.complaint}',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              'Due date: ${data.expectedDate.day}-${data.expectedDate.month}-${data.expectedDate.year}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 10.h,
          );
        },
        itemCount: datas.length,
      ),
    );
  }
}