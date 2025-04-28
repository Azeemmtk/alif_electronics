import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:alif_electronics/presentation/home/home_screen.dart';
import 'package:alif_electronics/presentation/report/report_screen.dart';
import 'package:alif_electronics/presentation/used_tv/used_tv_screen.dart';
import 'package:alif_electronics/presentation/wallet/wallet_screen.dart';
import 'package:alif_electronics/presentation/work/screens/work_screen.dart';
import 'package:alif_electronics/widgets/image_picker_widget.dart';

class HomeProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  File? _imageFile; // For mobile
  Uint8List? _webImageBytes; // For web
  final Box<dynamic> _profileBox = Hive.box<dynamic>('profile'); // Single box

  int get selectedIndex => _selectedIndex;
  File? get imageFile => _imageFile;
  Uint8List? get webImageBytes => _webImageBytes;

  final List<Widget> screens = [
    const HomeScreen(),
    const WorkScreen(),
    const UsedTvScreen(),
    const WalletScreen(),
    const ReportScreen(),
  ];

  final List<String> pageName = [
    'ALIF ELECTRONICS',
    'Work',
    'Used TV\'s',
    'Wallet',
    'Report',
  ];

  HomeProvider() {
    _loadImage();
  }

  void changeSelectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

  Future<void> _loadImage() async {
    final imageData = _profileBox.get('profile_image');
    if (imageData != null) {
      if (kIsWeb) {
        if (imageData is List<int>) {
          _webImageBytes = Uint8List.fromList(imageData);
          notifyListeners();
        }
      } else {
        if (imageData is String && await File(imageData).exists()) {
          _imageFile = File(imageData);
          notifyListeners();
        }
      }
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      if (kIsWeb) {
        final bytes = await pickedFile.readAsBytes();
        _webImageBytes = bytes;
        await _saveImage(bytes.toList());
      } else {
        _imageFile = File(pickedFile.path);
        await _saveImage(pickedFile.path);
      }
      notifyListeners();
    }
  }

  Future<void> _saveImage(dynamic data) async {
    await _profileBox.put('profile_image', data);
  }

  void showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ImagePickerOptions(
          onCameraTap: () {
            Navigator.pop(context);
            pickImage(ImageSource.camera);
          },
          onGalleryTap: () {
            Navigator.pop(context);
            pickImage(ImageSource.gallery);
          },
        );
      },
    );
  }
}