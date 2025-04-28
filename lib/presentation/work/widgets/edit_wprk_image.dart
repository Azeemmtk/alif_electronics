import 'dart:io';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:alif_electronics/presentation/work/screens/edit_work_screen.dart';
import 'package:alif_electronics/provider/work_provider.dart';
import 'package:alif_electronics/constants/conts.dart';

class EditWorkImage extends StatelessWidget {
  const EditWorkImage({
    super.key,
    required this.provider,
    required this.widget,
  });

  final WorkProvider provider;
  final EditWorkScreen widget;

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkProvider>(
      builder: (context, provider, child) {
        final hasNewImage = kIsWeb ? provider.webImageBytes != null : provider.imageFile != null;

        return Stack(
          children: [
            Container(
              height: 130.h,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(5.r),
                child: GestureDetector(
                  onTap: () {
                    provider.showImagePickerOptions(context);
                  },
                  child: Container(
                    height: 90.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(7.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7.r),
                      child: hasNewImage
                          ? kIsWeb
                          ? Image.memory(
                        provider.webImageBytes!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                              'assets/images/imglogo.png',
                              fit: BoxFit.cover,
                            ),
                      )
                          : Image.file(
                        provider.imageFile!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                              'assets/images/imglogo.png',
                              fit: BoxFit.cover,
                            ),
                      )
                          : _fallbackImage(widget.works.imagePath),
                    ),
                  ),
                ),
              ),
            ),
            hasNewImage
                ? Positioned(
              right: 3.w,
              top: 3.h,
              child: GestureDetector(
                onTap: () {
                  provider.showImagePickerOptions(context);
                },
                child: Container(
                  height: 30.h,
                  width: 30.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    color: mainColor,
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ),
            )
                : const SizedBox(),
          ],
        );
      },
    );
  }

  Widget _fallbackImage(dynamic imagePath) {
    if (kIsWeb && imagePath is List<int>) {
      return Image.memory(
        Uint8List.fromList(imagePath),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Image.asset(
          'assets/images/imglogo.png',
          fit: BoxFit.cover,
        ),
      );
    } else if (!kIsWeb && imagePath is String && imagePath.isNotEmpty) {
      return Image.file(
        File(imagePath),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Image.asset(
          'assets/images/imglogo.png',
          fit: BoxFit.cover,
        ),
      );
    }
    return Image.asset(
      'assets/images/imglogo.png',
      fit: BoxFit.cover,
    );
  }
}