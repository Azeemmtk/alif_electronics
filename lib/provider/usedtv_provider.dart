import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:alif_electronics/db_functions.dart';
import 'package:alif_electronics/models/used_tv/used_tv_model.dart';
import 'package:alif_electronics/widgets/image_picker_widget.dart';

class UsedtvProvider extends ChangeNotifier {
  final DbFunctions dbFunctions = DbFunctions();

  UsedtvProvider() {
    loadUsedTvList();
  }

  DateTime? selectedDate;
  File? imageFile; // For mobile
  Uint8List? webImageBytes; // For web

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      notifyListeners();
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        if (kIsWeb) {
          webImageBytes = await pickedFile.readAsBytes();
        } else {
          imageFile = File(pickedFile.path);
        }
        notifyListeners();
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  void showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ImagePickerOptions(
          onCameraTap: () {
            Navigator.pop(context);
            _pickImage(ImageSource.camera);
          },
          onGalleryTap: () {
            Navigator.pop(context);
            _pickImage(ImageSource.gallery);
          },
        );
      },
    );
  }

  List<UsedTvModel> _usedTvList = [];
  List<UsedTvModel> get usedTvList => _usedTvList;

  List<UsedTvModel> get availableUsedTv =>
      _usedTvList.where((tv) => tv.status == 'available').toList();

  List<UsedTvModel> get soldUsedTv =>
      _usedTvList.where((tv) => tv.status == 'sold').toList();

  int get currentMonthsoldtvcount {
    final now = DateTime.now();
    final currentMonth = now.month;
    final currentyear = now.year;

    return soldUsedTv
        .where(
          (tv) =>
      tv.soldDate?.month == currentMonth &&
          tv.soldDate?.year == currentyear,
    )
        .length;
  }

  double get totalSoldTvMarketPrice {
    final now = DateTime.now();
    final currentMonth = now.month;
    final currentYear = now.year;

    return soldUsedTv
        .where((tv) =>
    tv.purchaseDate.month == currentMonth &&
        tv.purchaseDate.year == currentYear)
        .fold(0.0, (sum, tv) => sum + tv.marketPrice);
  }

  Future<void> loadUsedTvList() async {
    _usedTvList = dbFunctions.getAllUsedTvs();
    notifyListeners();
  }

  String _generateUsedTvId() {
    int count = _usedTvList.length + 1;
    return 'UT${count.toString().padLeft(4, '0')}';
  }

  Future<void> saveUsedTv({
    required String brandName,
    required String modelNumber,
    required String details,
    required double purchaseRate,
    required double marketPrice,
  }) async {
    if ((kIsWeb && webImageBytes == null) || (!kIsWeb && imageFile == null) || selectedDate == null) {
      print('Missing required fields: image or date');
      return;
    }

    final String usedTvId = _generateUsedTvId();

    final usedTv = UsedTvModel(
      usedTvId: usedTvId,
      imagePath: kIsWeb ? webImageBytes!.toList() : imageFile!.path,
      brandName: brandName,
      modelNumber: modelNumber,
      details: details,
      purchaseDate: selectedDate!,
      purchaseRate: purchaseRate,
      marketPrice: marketPrice,
    );

    try {
      await dbFunctions.addUsedTv(usedTv);
      await loadUsedTvList();
      print('Added to Hive: $usedTvId');
      imageFile = null;
      webImageBytes = null;
      selectedDate = null;
      notifyListeners();
    } catch (e) {
      print('Error saving UsedTv: $e');
    }
  }

  Future<void> updateUsedTv({
    required String usedTvId,
    required String brandName,
    required String modelNumber,
    required String details,
    required double purchaseRate,
    required double marketPrice,
  }) async {
    final box = Hive.box<UsedTvModel>('used_tv_box');
    dynamic keyToUpdate;
    UsedTvModel? existingTv;

    // Find the key for the given usedTvId
    for (var key in box.keys) {
      final tv = box.get(key);
      if (tv != null && tv.usedTvId == usedTvId) {
        keyToUpdate = key;
        existingTv = tv;
        break;
      }
    }

    if (keyToUpdate != null && existingTv != null) {
      final updatedTv = UsedTvModel(
        usedTvId: usedTvId,
        imagePath: kIsWeb
            ? (webImageBytes != null ? webImageBytes!.toList() : existingTv.imagePath)
            : (imageFile != null ? imageFile!.path : existingTv.imagePath),
        brandName: brandName,
        modelNumber: modelNumber,
        details: details,
        purchaseDate: selectedDate ?? existingTv.purchaseDate,
        purchaseRate: purchaseRate,
        marketPrice: marketPrice,
        soldDate: existingTv.soldDate,
        status: existingTv.status,
      );

      try {
        await box.put(keyToUpdate, updatedTv);
        await loadUsedTvList();
        print('Updated in Hive: $usedTvId at key: $keyToUpdate');
        imageFile = null;
        webImageBytes = null;
        selectedDate = null;
        notifyListeners();
      } catch (e) {
        print('Error updating UsedTv: $e');
      }
    } else {
      print('Error: Used TV with ID $usedTvId not found in Hive');
    }
  }

  Future<void> markAsSold(String usedTvId) async {
    final box = Hive.box<UsedTvModel>('used_tv_box');
    dynamic keyToUpdate;
    UsedTvModel? existingTv;

    for (var key in box.keys) {
      final tv = box.get(key);
      if (tv != null && tv.usedTvId == usedTvId) {
        keyToUpdate = key;
        existingTv = tv;
        break;
      }
    }

    if (keyToUpdate != null && existingTv != null) {
      final updatedTv = UsedTvModel(
        usedTvId: existingTv.usedTvId,
        imagePath: existingTv.imagePath,
        brandName: existingTv.brandName,
        modelNumber: existingTv.modelNumber,
        details: existingTv.details,
        purchaseDate: existingTv.purchaseDate,
        purchaseRate: existingTv.purchaseRate,
        marketPrice: existingTv.marketPrice,
        soldDate: DateTime.now(),
        status: 'sold',
      );

      try {
        await box.put(keyToUpdate, updatedTv);
        await loadUsedTvList();
        print('Marked as Sold in Hive: $usedTvId at key: $keyToUpdate');
        notifyListeners();
      } catch (e) {
        print('Error marking as sold: $e');
      }
    } else {
      print('Error: Used TV with ID $usedTvId not found in Hive');
    }
  }

  Future<void> deleteUsedTv(String usedTvId) async {
    final box = Hive.box<UsedTvModel>('used_tv_box');
    dynamic keyToDelete;

    for (var key in box.keys) {
      final tv = box.get(key);
      if (tv != null && tv.usedTvId == usedTvId) {
        keyToDelete = key;
        break;
      }
    }

    if (keyToDelete != null) {
      try {
        await box.delete(keyToDelete);
        await loadUsedTvList();
        print('Deleted from Hive: $usedTvId at key: $keyToDelete');
        notifyListeners();
      } catch (e) {
        print('Error deleting UsedTv: $e');
      }
    } else {
      print('Error: Used TV with ID $usedTvId not found in Hive');
    }
  }
}