import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../provider/usedtv_provider.dart';

class UsedTvAddImage extends StatelessWidget {
  const UsedTvAddImage({
    super.key,
    required this.provider,
  });

  final UsedtvProvider provider;

  @override
  Widget build(BuildContext context) {
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
            child: kIsWeb
                ? (provider.webImageBytes != null
                ? ClipOval(
              child: Image.memory(
                provider.webImageBytes!,
                fit: BoxFit.cover,
                width: 180,
                height: 180,
              ),
            )
                : Image.asset('assets/images/imglogo.png'))
                : (provider.imageFile != null
                ? ClipOval(
              child: Image.file(
                provider.imageFile!,
                fit: BoxFit.cover,
                width: 180,
                height: 180,
              ),
            )
                : Image.asset('assets/images/imglogo.png')),
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
  }
}