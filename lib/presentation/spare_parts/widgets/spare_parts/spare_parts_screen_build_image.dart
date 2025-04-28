import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb, Uint8List;
import 'package:flutter/material.dart';
import 'package:alif_electronics/models/spare_parts/spare_parts_model.dart';
import 'package:alif_electronics/provider/spare_parts_provider.dart';

Widget SparePartsBuildImage(SparePartsProvider provider, SparepartsModel data) {
  final String? imgPath = data.img;
  final String? categoryImagePath =
  provider.customCategories[data.category]?['imagePath'];

  // Helper function to parse stringified List<int> to Uint8List
  Uint8List? parseWebImage(String? path) {
    if (path == null || !path.startsWith('[') || !path.endsWith(']')) {
      return null;
    }
    try {
      // Remove brackets and split by comma
      final cleaned = path.substring(1, path.length - 1).trim();
      if (cleaned.isEmpty) return null;
      final numbers = cleaned.split(',').map((e) => int.tryParse(e.trim()));
      if (numbers.any((n) => n == null)) return null;
      return Uint8List.fromList(numbers.cast<int>().toList());
    } catch (e) {
      print('Error parsing web image: $e');
      return null;
    }
  }

  if (imgPath == null || imgPath.isEmpty || imgPath == 'Unknown') {
    // If img is invalid, try category image
    if (categoryImagePath != null && categoryImagePath != 'Unknown') {
      if (kIsWeb) {
        // Check if categoryImagePath is a stringified List<int>
        final webImageBytes = parseWebImage(categoryImagePath);
        if (webImageBytes != null) {
          return Image.memory(
            webImageBytes,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey.withOpacity(0.3),
              child: const Center(child: Text('Image Error')),
            ),
          );
        }
        // Fallback to asset or placeholder
        if (categoryImagePath.startsWith('assets/')) {
          return Image.asset(
            categoryImagePath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey.withOpacity(0.3),
              child: const Center(child: Text('Image Error')),
            ),
          );
        }
      } else {
        // Mobile: Try File
        final file = File(categoryImagePath);
        if (file.existsSync()) {
          return Image.file(
            file,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey.withOpacity(0.3),
              child: const Center(child: Text('Image Error')),
            ),
          );
        }
      }
    }
    // Fallback to placeholder
    return Container(
      color: Colors.grey.withOpacity(0.3),
      child: const Center(child: Text('No Image')),
    );
  } else if (imgPath.startsWith('assets/')) {
    // Asset image
    return Image.asset(
      imgPath,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        color: Colors.grey.withOpacity(0.3),
        child: const Center(child: Text('Image Error')),
      ),
    );
  } else {
    // File image (mobile) or category fallback
    if (kIsWeb) {
      // Web: Check if imgPath is a stringified List<int>
      final webImageBytes = parseWebImage(imgPath);
      if (webImageBytes != null) {
        return Image.memory(
          webImageBytes,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.grey.withOpacity(0.3),
            child: const Center(child: Text('Image Error')),
          ),
        );
      }
      // Fallback to category image
      if (categoryImagePath != null && categoryImagePath != 'Unknown') {
        final categoryWebImageBytes = parseWebImage(categoryImagePath);
        if (categoryWebImageBytes != null) {
          return Image.memory(
            categoryWebImageBytes,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey.withOpacity(0.3),
              child: const Center(child: Text('Image Error')),
            ),
          );
        }
        if (categoryImagePath.startsWith('assets/')) {
          return Image.asset(
            categoryImagePath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey.withOpacity(0.3),
              child: const Center(child: Text('Image Error')),
            ),
          );
        }
      }
    } else {
      // Mobile: Try File
      final file = File(imgPath);
      if (file.existsSync()) {
        return Image.file(
          file,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.grey.withOpacity(0.3),
            child: const Center(child: Text('Image Error')),
          ),
        );
      }
      // Fallback to category image
      if (categoryImagePath != null && categoryImagePath != 'Unknown') {
        final categoryFile = File(categoryImagePath);
        if (categoryFile.existsSync()) {
          return Image.file(
            categoryFile,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey.withOpacity(0.3),
              child: const Center(child: Text('Image Error')),
            ),
          );
        }
      }
    }
    // Fallback to placeholder
    return Container(
      color: Colors.grey.withOpacity(0.3),
      child: const Center(child: Text('Image Not Found')),
    );
  }
}