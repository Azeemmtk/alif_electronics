import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb, Uint8List;
import 'package:flutter/material.dart';

Widget buildImage(String? imagePath) {
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

  if (imagePath != null && imagePath != 'Unknown') {
    if (kIsWeb) {
      // Web: Check if imagePath is a stringified List<int>
      final webImageBytes = parseWebImage(imagePath);
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
    } else {
      // Mobile: Try File
      final file = File(imagePath);
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
}