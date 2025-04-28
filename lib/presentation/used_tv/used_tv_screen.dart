import 'dart:io';
import 'package:alif_electronics/presentation/used_tv/usedtv_details_screen.dart';
import 'package:alif_electronics/provider/usedtv_provider.dart';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:alif_electronics/constants/conts.dart';

class UsedTvScreen extends StatelessWidget {
  const UsedTvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UsedtvProvider>(context);
    final datas = provider.availableUsedTv;
    return Padding(
      padding: const EdgeInsets.all(15),
      child: datas.isEmpty
          ? Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width <= 394 ? 70.h : 18.h,
            ),
            Lottie.asset('assets/lottie/nodata.json'),
            const Text(
              'No used TV\'s',
              style: TextStyle(
                fontSize: 18,
                color: mainColor,
              ),
            )
          ],
        ),
      )
          : SingleChildScrollView(
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: datas.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: kIsWeb?3: 2,
            crossAxisSpacing: 7,
            mainAxisSpacing: 13,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final data = datas[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => UsedtvDetailsScreen(
                      index: index,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 7,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Card(
                  shadowColor: mainColor,
                  color: mainColor,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: mainColor),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width<=394? 122.h: MediaQuery.of(context).size.width/3-69 ,
                        width: double.infinity,
                        child: Hero(
                          tag: 'hero-image${data.usedTvId}-$index',
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.r),
                              topRight: Radius.circular(15.r),
                            ),
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
                      Text(
                        data.brandName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '₹: ${data.marketPrice}/-',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 10,
                              color: Colors.black45,
                              offset: Offset(3, 3),
                            )
                          ],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}