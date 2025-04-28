import 'dart:io';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:alif_electronics/constants/conts.dart';
import 'package:alif_electronics/models/work/work_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alif_electronics/presentation/wallet/payment_slip_screen.dart';

class PendingPaymentWidget extends StatelessWidget {
  const PendingPaymentWidget({
    super.key,
    required this.pendingData,
  });

  final List<WorkModel> pendingData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 141.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final data = pendingData[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => PaymentSlipScreen(
                    index: index,
                  ),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(
                  top: 6.h, left: 6.w, right: 6.w, bottom: 12.h),
              child: Container(
                width: 313.w,
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
                  color: Colors.white,
                  elevation: 6,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      border: Border.all(color: mainColor),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.r),
                              bottomLeft: Radius.circular(12.r),
                            ),
                          ),
                          child: SizedBox(
                            height: 113,
                            width: 120,
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
                        ),
                        SizedBox(width: 10.w,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '${data.brandName} ${data.modelNumber}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                // color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 159.w,
                              child: Text(
                                'C Name: ${data.customerName}',
                                style: TextStyle(
                                    fontSize: 14,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                            Text(
                              'Phone: ${data.phoneNumber}',
                              style: TextStyle(
                                  fontSize: 14,
                              ),
                            ),

                            Text.rich(
                              TextSpan(
                                  text: 'Amount: ',
                                  style: TextStyle(
                                      fontSize: 14,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '₹ ${data.expectedAmount}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                      ),
                                    )
                                  ]),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 6.h,
          );
        },
        itemCount: pendingData.length,
      ),
    );
  }
}
