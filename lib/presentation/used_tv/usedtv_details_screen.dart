import 'dart:io';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:alif_electronics/constants/conts.dart';
import 'package:alif_electronics/presentation/used_tv/widgets/used_tv_details_button.dart';
import 'package:alif_electronics/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:alif_electronics/provider/usedtv_provider.dart';

class UsedtvDetailsScreen extends StatelessWidget {
  const UsedtvDetailsScreen({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UsedtvProvider>(context);
    final data = provider.availableUsedTv[index];
    return Scaffold(
      appBar: customAppbar(
          context: context, icon: Icons.arrow_back, text: 'Used TV detail\'s'),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Container(
                height: MediaQuery.of(context).size.width<=394? 250.h: 400.h,
                width: 350.w,
                decoration: BoxDecoration(
                  border: Border.all(color: mainColor),
                    borderRadius: BorderRadius.circular(11.r),
                ),
                child: Hero(
                  tag: 'hero-image${data.usedTvId}-$index',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: kIsWeb
                        ? (data.imagePath is List<int>
                        ? Image.memory(
                      Uint8List.fromList(data.imagePath as List<int>),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Image.asset(
                            'assets/images/imglogo.png',
                            fit: BoxFit.cover,
                          ),
                    )
                        : Image.asset(
                      'assets/images/imglogo.png',
                      fit: BoxFit.cover,
                    ))
                        : (data.imagePath is String && (data.imagePath as String).isNotEmpty
                        ? Image.file(
                      File(data.imagePath as String),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Image.asset(
                            'assets/images/imglogo.png',
                            fit: BoxFit.cover,
                          ),
                    )
                        : Image.asset(
                      'assets/images/imglogo.png',
                      fit: BoxFit.cover,
                    )),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'TV Id: ${data.usedTvId}',
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Brand and Model',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              '${data.brandName} ${data.modelNumber}',
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(
                              height: 13.h,
                            ),
                            const Text(
                              'Details',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              data.details,
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(
                              height: 13.h,
                            ),
                            const Text(
                              'Used for',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'Year: ${(DateTime.now().year - (data.purchaseDate.year)).abs()}    Month:${(DateTime.now().month - (data.purchaseDate.month)).abs()}    Day: ${(DateTime.now().day - (data.purchaseDate.day)).abs()}',
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(
                              height: 13.h,
                            ),
                            const Text(
                              'Purchase rate',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              '₹ ${data.purchaseRate}/-',
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 13.h,
                            ),
                            const Text(
                              'Market price',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              '₹ ${data.marketPrice}/-',
                              style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      UsedTvDetailsButton(data: data, provider: provider)
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