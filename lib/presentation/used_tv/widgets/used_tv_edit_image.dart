import 'dart:io';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:alif_electronics/presentation/used_tv/edit_usedtv_screen.dart';
import 'package:alif_electronics/provider/usedtv_provider.dart';

class UsedTvEditImage extends StatelessWidget {
  const UsedTvEditImage({
    super.key,
    required this.provider,
    required this.widget,
  });

  final UsedtvProvider provider;
  final EditUsedtvScreen widget;

  @override
  Widget build(BuildContext context) {
    return Consumer<UsedtvProvider>(
      builder: (context, provider, child) {
        return Center(
          child: Stack(
            children: [
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  border: Border.all(color: Colors.grey),
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: kIsWeb
                      ? (provider.webImageBytes != null
                      ? Image.memory(
                    provider.webImageBytes!,
                    fit: BoxFit.cover,
                    width: 180,
                    height: 180,
                    errorBuilder: (context, error, stackTrace) =>
                        _fallbackImage(widget.usedTv.imagePath),
                  )
                      : _fallbackImage(widget.usedTv.imagePath))
                      : (provider.imageFile != null
                      ? Image.file(
                    provider.imageFile!,
                    fit: BoxFit.cover,
                    width: 180,
                    height: 180,
                    errorBuilder: (context, error, stackTrace) =>
                        _fallbackImage(widget.usedTv.imagePath),
                  )
                      : _fallbackImage(widget.usedTv.imagePath)),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 15,
                child: GestureDetector(
                  onTap: () {
                    provider.showImagePickerOptions(context);
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      shape: BoxShape.circle,
                      color: Colors.blue[50],
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _fallbackImage(dynamic imagePath) {
    if (kIsWeb && imagePath is List<int>) {
      return Image.memory(
        Uint8List.fromList(imagePath),
        fit: BoxFit.cover,
        width: 180.w,
        height: 180.h,
        errorBuilder: (context, error, stackTrace) => Image.asset(
          'assets/images/imglogo.png',
          fit: BoxFit.cover,
          width: 180.w,
          height: 180.h,
        ),
      );
    } else if (!kIsWeb && imagePath is String && imagePath.isNotEmpty) {
      return Image.file(
        File(imagePath),
        fit: BoxFit.cover,
        width: 180.w,
        height: 180.h,
        errorBuilder: (context, error, stackTrace) => Image.asset(
          'assets/images/imglogo.png',
          fit: BoxFit.cover,
          width: 180.w,
          height: 180.h,
        ),
      );
    }
    return Image.asset(
      'assets/images/imglogo.png',
      fit: BoxFit.cover,
      width: 180.w,
      height: 180.h,
    );
  }
}