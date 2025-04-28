import 'dart:io';
import 'package:alif_electronics/constants/conts.dart';
import 'package:alif_electronics/provider/home_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopOwnerDetails extends StatelessWidget {
  const ShopOwnerDetails({
    super.key,
    required this.homeProvider,
  });

  final HomeProvider homeProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 250,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r),
                ),
              ),
            ),
            Positioned(
              top: -5.h,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    'VMC/2025/TVR/015',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 55,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white,
                        width: 4,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: kIsWeb
                          ? (homeProvider.webImageBytes != null
                              ? Image.memory(
                                  homeProvider.webImageBytes!,
                                  fit: BoxFit.cover,
                                  width: 200,
                                  height: 200,
                                )
                              : Image.asset(
                                  'assets/images/profile.png',
                                  fit: BoxFit.cover,
                                  width: 200,
                                  height: 200,
                                ))
                          : (homeProvider.imageFile != null
                              ? Image.file(
                                  homeProvider.imageFile!,
                                  fit: BoxFit.cover,
                                  width: 200,
                                  height: 200,
                                )
                              : Image.asset(
                                  'assets/images/profile.png',
                                  fit: BoxFit.cover,
                                  width: 200,
                                  height: 200,
                                )),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: MediaQuery.of(context).size.width <= 394
                  ? 110.h
                  : (MediaQuery.of(context).size.width / 2) - 85,
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  shape: BoxShape.circle,
                  color: mainColor,
                ),
                child: IconButton(
                  onPressed: () {
                    homeProvider.showImagePickerOptions(context);
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Owner: ',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: mainColor,
              ),
            ),
            Text(
              'Muhammed Ashraf kp',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: mainColor.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
