import 'package:flutter/material.dart';
import 'package:alif_electronics/constants/conts.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> customSnackbar(
    {required BuildContext context, required String Message}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        Message,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      backgroundColor: mainColor,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating, // Makes the snackbar float
      margin: const EdgeInsets.symmetric(
          horizontal: 10, vertical: 10), // Adds space outside
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6), // Rounds the corners
      ),
    ),
  );
}
