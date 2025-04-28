import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alif_electronics/constants/conts.dart';

class ImagePickerOptions extends StatelessWidget {

  const ImagePickerOptions({
    super.key,
    required this.onCameraTap,
    required this.onGalleryTap,
  });
  final VoidCallback onCameraTap;
  final VoidCallback onGalleryTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      height: 153,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt, color: mainColor),
            title: const Text(
              'Take a photo',
              style: TextStyle(color: mainColor),
            ),
            onTap: onCameraTap,
          ),
          ListTile(
            leading: const Icon(Icons.photo_library, color: mainColor),
            title: const Text(
              'Choose from gallery',
              style: TextStyle(color: mainColor),
            ),
            onTap: onGalleryTap,
          ),
        ],
      ),
    );
  }
}
