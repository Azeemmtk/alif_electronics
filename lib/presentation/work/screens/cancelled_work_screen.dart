import 'dart:io';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:alif_electronics/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:alif_electronics/provider/work_provider.dart';
import 'package:alif_electronics/constants/conts.dart';

class CancelledWorkScreen extends StatelessWidget {
  const CancelledWorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WorkProvider>(context);
    final datas = provider.cancelledWork;
    return Scaffold(
      appBar: customAppbar(
          context: context, icon: Icons.arrow_back, text: 'Cancelled work'),
      body: Padding(
        padding: EdgeInsets.all(15.w),
        child: Column(
          children: [
            datas.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.width<=394? 70.h: 10.w),
                        Lottie.asset('assets/lottie/nodata.json'),
                        const Text(
                          'Works not cancelled',
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
                        return Card(
                          elevation: 6,
                          shadowColor: Colors.black,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(7.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 90,
                                      width: 150,
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
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                'Brand: ',
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                data.brandName,
                                                style:
                                                    const TextStyle(fontSize: 17),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                'Model: ',
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                data.modelNumber,
                                                style:
                                                    const TextStyle(fontSize: 17),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                'Issue: ',
                                                style: TextStyle(
                                                  fontSize: 1,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  data.complaint,
                                                  style: const TextStyle(
                                                      fontSize: 17),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                'Due date: ',
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                '${data.expectedDate.day}-${data.expectedDate.month}-${data.expectedDate.year}',
                                                style:
                                                    const TextStyle(fontSize: 17),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h), // Add some spacing
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Reason: ',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Expanded(
                                      // Wrap the Text in Expanded to allow wrapping
                                      child: Text(
                                        data.cancellationReason,
                                        style: const TextStyle(fontSize: 17),
                                        softWrap: true,
                                        maxLines: null,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 10.h);
                      },
                      itemCount: datas.length,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
