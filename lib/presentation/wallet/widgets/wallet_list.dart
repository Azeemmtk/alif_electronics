import 'dart:io';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:alif_electronics/constants/conts.dart';
import 'package:alif_electronics/models/work/work_model.dart';
import 'package:alif_electronics/presentation/wallet/payment_slip_screen.dart';
import 'package:alif_electronics/presentation/wallet/widgets/wallet_tv_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class WalletList extends StatelessWidget {
  const WalletList({
    super.key,
    required this.datas,
  });

  final List<WorkModel> datas;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 15.r),
        itemBuilder: (context, index) {
          final data = datas[index];
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
                        height: 110,
                        width: 130,
                        child: Hero(
                          tag: 'image-${data.workId}',
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(11.r),
                              bottomLeft: Radius.circular(11.r),
                            ),
                            child: kIsWeb
                                ? Image.memory(
                                    Uint8List.fromList(
                                        data.imagePath as List<int>),
                                    fit: BoxFit.fill,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
                                      'assets/images/imglogo.png',
                                      fit: BoxFit.fill,
                                    ),
                                  )
                                : Image.file(
                                    File(data.imagePath as String),
                                    fit: BoxFit.fill,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
                                      'assets/images/imglogo.png',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width<=394? 110.h:  131.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${data.brandName} ${data.modelNumber}',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            WalletTvDetails(
                              head: 'C Name: ',
                              data: data.customerName,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Status: ',
                                  style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  data.status,
                                  style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    color: data.status == 'Pending'
                                        ? const Color(0xFFFB0069)
                                        : data.status == 'In Progress'
                                            ? const Color(0xFFA3A539)
                                            : const Color(0xFF326732),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            WalletTvDetails(
                              head: 'Completion date: ',
                              data:
                                  '${data.expectedDate.day}-${data.expectedDate.month}-${data.expectedDate.year}',
                            ),
                            WalletTvDetails(
                              head: 'Amount: ',
                              data: '₹${data.expectedAmount}',
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
