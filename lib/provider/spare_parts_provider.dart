import 'dart:io';
import 'package:alif_electronics/db_functions.dart';
import 'package:alif_electronics/models/spare_parts/spare_parts_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:alif_electronics/widgets/image_picker_widget.dart';
import 'package:alif_electronics/widgets/customsnackbar.dart';

class SparePartsProvider extends ChangeNotifier {
  final DbFunctions dbFunctions = DbFunctions();

  int selectedIndex = -1;

  void selectItem(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  File? imageFile;
  Uint8List? webImageBytes; // For web

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

  String? selectedValue;

  List<String> dropdownItems = ['Resistor', 'Capacitor', 'Transistor', 'IC'];

  Map<String, Map<String, String>> customCategories = {
    'Resistor': {'extra1': 'Power rating', 'extra2': 'Tolerance'},
    'Capacitor': {'extra1': 'Capacitance', 'extra2': 'Voltage'},
    'Transistor': {'extra1': 'Max Voltage', 'extra2': 'Max Current'},
    'IC': {'extra1': 'Input Range', 'extra2': 'Output Range'},
  };

  void selectDropDownItem(String? newValue) {
    selectedValue = newValue;
    notifyListeners();
  }

  List<Map<String, dynamic>> resistors = [];
  List<Map<String, dynamic>> capacitors = [];
  List<Map<String, dynamic>> ics = [];
  List<Map<String, dynamic>> transistors = [];
  String fileName = 'No file selected';
  File? files; // Nullable to avoid uninitialized access
  Uint8List? lastUploadedBytes; // Store Excel bytes for web

  SparePartsProvider() {
    _initializeHive();
  }

  Future<void> _initializeHive() async {
    _loadCategoriesFromHive();
    loadAllData();
    dbFunctions.watchSpareParts().listen((event) {
      loadAllData();
      notifyListeners();
    });
  }

  void _loadCategoriesFromHive() {
    var storedCategories = dbFunctions.getCategories();
    if (storedCategories != null) {
      customCategories = storedCategories;
      dropdownItems = customCategories.keys.toList();
    }
    notifyListeners();
  }

  Future<void> _saveCategoriesToHive() async {
    await dbFunctions.saveCategories(customCategories);
  }

  double get totalSparePartsValue => dbFunctions.getTotalSparePartsValue();

  Future<void> addNewCategory({
    required String categoryName,
    required String property1Name,
    required String property2Name,
    dynamic imagePath, // Supports String (mobile) or List<int> (web)
  }) async {
    if (!dropdownItems.contains(categoryName)) {
      dropdownItems.add(categoryName);
      customCategories[categoryName] = {
        'extra1': property1Name,
        'extra2': property2Name,
        'imagePath': imagePath?.toString() ?? 'Unknown',
      };
      await _saveCategoriesToHive();
      imageFile = null;
      webImageBytes = null;
      notifyListeners();
      print(
          'Added new category: $categoryName with properties $property1Name, $property2Name, imagePath: ${imagePath is List<int> ? 'List<int> length: ${imagePath.length}' : imagePath}');
    } else {
      print('Category $categoryName already exists!');
    }
  }

  Future<void> editCategory({
    required String oldCategoryName,
    required String newCategoryName,
    required String property1Name,
    required String property2Name,
    dynamic imagePath, // Supports String (mobile) or List<int> (web)
  }) async {
    if (customCategories.containsKey(oldCategoryName)) {
      // Update customCategories
      customCategories.remove(oldCategoryName);
      dropdownItems.remove(oldCategoryName);

      dropdownItems.add(newCategoryName);
      customCategories[newCategoryName] = {
        'extra1': property1Name,
        'extra2': property2Name,
        'imagePath': imagePath?.toString() ??
            customCategories[oldCategoryName]?['imagePath'] ??
            'Unknown',
      };
      await _saveCategoriesToHive();

      // Update SparepartsModel instances in Hive
      final spareParts = dbFunctions.getAllSpareParts();
      for (var part in spareParts) {
        if (part.category == oldCategoryName) {
          final updatedPart = SparepartsModel(
            category: newCategoryName,
            model: part.model,
            location: part.location,
            price: part.price,
            count: part.count,
            extra1: part.extra1,
            extra2: part.extra2,
            img: part.img,
          );
          await dbFunctions.updateSparePart(part.model, updatedPart);
          print('Updated spare part ${part.model} category from $oldCategoryName to $newCategoryName');
        }
      }

      imageFile = null;
      webImageBytes = null;
      loadAllData(); // Refresh spare parts list
      notifyListeners();
      print(
          'Edited category: $oldCategoryName to $newCategoryName, imagePath: ${imagePath is List<int> ? 'List<int> length: ${imagePath.length}' : imagePath}');
    }
  }

  Future<void> deleteCategory(String categoryName) async {
    if (customCategories.containsKey(categoryName)) {
      customCategories.remove(categoryName);
      dropdownItems.remove(categoryName);
      if (selectedValue == categoryName) {
        selectedValue = null;
      }
      await _saveCategoriesToHive();
      notifyListeners();
    }
  }

  Future<void> pickAndReadExcel(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
      );

      if (result != null && result.files.single != null) {
        final platformFile = result.files.single;
        fileName = platformFile.name;

        if (kIsWeb) {
          // Web: Read bytes directly
          if (platformFile.bytes != null) {
            lastUploadedBytes = platformFile.bytes!;
            await readExcel(lastUploadedBytes!, context);
          } else {
            customSnackbar(
              context: context,
              Message: 'Failed to read file bytes',
            );
            fileName = 'No file selected';
            lastUploadedBytes = null;
          }
        } else {
          // Mobile: Read from file path
          if (platformFile.path != null) {
            files = File(platformFile.path!);
            await readExcel(files!, context);
          } else {
            customSnackbar(
              context: context,
              Message: 'Failed to access file path',
            );
            fileName = 'No file selected';
            files = null;
          }
        }
        notifyListeners();
      } else {
        customSnackbar(
          context: context,
          Message: 'No file selected',
        );
        fileName = 'No file selected';
        lastUploadedBytes = null;
        notifyListeners();
      }
    } catch (e) {
      print('Error picking Excel file: $e');
      customSnackbar(
        context: context,
        Message: 'Failed to pick file: $e',
      );
      fileName = 'No file selected';
      lastUploadedBytes = null;
      notifyListeners();
    }
  }

  Future<void> readExcel(dynamic input, BuildContext context) async {
    try {
      Uint8List bytes;
      if (input is File) {
        bytes = input.readAsBytesSync();
      } else if (input is Uint8List) {
        bytes = input;
      } else {
        throw Exception('Invalid input type for readExcel');
      }

      var excel = Excel.decodeBytes(bytes);

      resistors.clear();
      capacitors.clear();
      ics.clear();
      transistors.clear();

      for (var table in excel.tables.keys) {
        var sheet = excel.tables[table]!;
        List<List<String>> data = [];

        for (var row in sheet.rows) {
          data.add(row.map((cell) => cell?.value.toString() ?? '').toList());
        }

        if (data.isNotEmpty) {
          for (int i = 1; i < data.length; i++) {
            List<String> row = data[i];
            String model = row[1];
            String name = row[0].toLowerCase();

            Map<String, dynamic> item = {
              'model': row[1],
              'location': row[4],
              'price': int.tryParse(row[5]) ?? 0,
              'count': int.tryParse(row[6]) ?? 0,
            };

            if (name.contains('resister')) {
              item['power rating'] = row[2];
              item['tolerance'] = row[3];
              resistors.add(item);
            } else if (name.contains('capacitor')) {
              item['capacitance'] = row[2];
              item['tolerance'] = row[3];
              capacitors.add(item);
            } else if (name.contains('ic')) {
              item['input range'] = row[2];
              item['output range'] = row[3];
              ics.add(item);
            } else if (name.contains('transistor')) {
              item['max voltage'] = row[2];
              item['max current'] = row[3];
              transistors.add(item);
            }
          }
        }
      }

      print('File Name: $fileName');
      print('Resistors: $resistors');
      print('Capacitors: $capacitors');
      print('ICs: $ics');
      print('Transistors: $transistors');
    } catch (e) {
      print('Error reading Excel file: $e');
      customSnackbar(
        context: context,
        Message: 'Failed to read Excel file: $e',
      );
      fileName = 'No file selected';
      resistors.clear();
      capacitors.clear();
      ics.clear();
      transistors.clear();
      lastUploadedBytes = null;
      notifyListeners();
    }
  }

  Future<bool> addSparepartsToHive(BuildContext context) async {
    if (kIsWeb && lastUploadedBytes == null || !kIsWeb && files == null) {
      customSnackbar(
        context: context,
        Message: 'No file selected for adding to Hive',
      );
      return false;
    }

    try {
      Uint8List bytes = kIsWeb ? lastUploadedBytes! : files!.readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);

      for (var table in excel.tables.keys) {
        var sheet = excel.tables[table]!;
        List<List<String>> data = [];

        for (var row in sheet.rows) {
          data.add(row.map((cell) => cell?.value.toString() ?? '').toList());
        }

        if (data.isNotEmpty) {
          for (int i = 1; i < data.length; i++) {
            List<String> row = data[i];

            if (row.length < 7 || row[1].trim().isEmpty) {
              print(' Skipping empty or invalid row: $row');
              continue;
            }

            String model = row[1];
            String name = row[0].toLowerCase();
            int newCount = int.tryParse(row[6]) ?? 0;

            SparepartsModel? existingItem = dbFunctions.getSparePart(model);

            if (existingItem != null) {
              existingItem.count += newCount;
              await dbFunctions.updateSparePart(model, existingItem);
              print(
                  ' Updated ${existingItem.model}: New Count = ${existingItem.count}');
            } else {
              var spareparts = SparepartsModel(
                category: name.contains('resister')
                    ? 'Resistor'
                    : name.contains('capacitor')
                    ? 'Capacitor'
                    : name.contains('ic')
                    ? 'IC'
                    : name.contains('transistor')
                    ? 'Transistor'
                    : 'Unknown',
                model: model,
                location: row[4],
                price: int.tryParse(row[5]) ?? 0,
                count: newCount,
                extra1: row[2],
                extra2: row[3],
                img: name.contains('resister')
                    ? 'assets/images/resister.png'
                    : name.contains('capacitor')
                    ? 'assets/images/capasotor.png'
                    : name.contains('ic')
                    ? 'assets/images/ic.png'
                    : name.contains('transistor')
                    ? 'assets/images/trasnsister.png'
                    : 'Unknown',
              );

              await dbFunctions.addSparePart(spareparts, model);
              print(' Added ${spareparts.model} to Hive');
            }
          }
        }
      }

      print(' Final Hive Data Count: ${dbFunctions.getAllSpareParts().length}');

      resistors.clear();
      capacitors.clear();
      ics.clear();
      transistors.clear();
      fileName = 'No file selected';
      files = null;
      lastUploadedBytes = null;

      loadAllData();
      notifyListeners();
      return true;
    } catch (e) {
      print('Error adding spare parts to Hive: $e');
      customSnackbar(
        context: context,
        Message: 'Failed to add spare parts: $e',
      );
      return false;
    }
  }

  Future<void> printAllSpareParts() async {
    print(' Checking Hive box contents...');
    print(' Box Length: ${dbFunctions.getAllSpareParts().length}');

    if (dbFunctions.getAllSpareParts().isEmpty) {
      print(' No data found in Hive!');
      return;
    }

    print(' All Spare Parts in Hive:');
    for (var part in dbFunctions.getAllSpareParts()) {
      print("""
            --------------------------------------
            Category  : ${part.category}
            Model     : ${part.model}
            Location  : ${part.location}
            Price     : ${part.price}
            Count     : ${part.count}
            Extra1    : ${part.extra1 ?? 'N/A'}
            Extra2    : ${part.extra2 ?? 'N/A'}
            img       : ${part.img ?? 'N/A'}
            --------------------------------------
            """);
    }
  }

  List<SparepartsModel> getAllSpareParts() {
    return dbFunctions.getAllSpareParts();
  }

  List<SparepartsModel> _allSpareParts = [];
  List<SparepartsModel> _filteredSpareParts = [];

  List<SparepartsModel> get filteredSpareParts => _filteredSpareParts;

  void searchSpareParts(String query) {
    if (query.isEmpty) {
      _filteredSpareParts = _allSpareParts;
    } else {
      _filteredSpareParts = _allSpareParts.where((part) {
        return part.category.toLowerCase().contains(query.toLowerCase()) ||
            part.model.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  Future<void> increaseSparePartCount(String model, int increment) async {
    SparepartsModel? existingItem = dbFunctions.getSparePart(model);

    if (existingItem != null) {
      existingItem.count += increment;
      await dbFunctions.updateSparePart(model, existingItem);
      print(
          ' Increased ${existingItem.model} count: New Count = ${existingItem.count}');
      notifyListeners();
    } else {
      print(' Spare part with model $model not found!');
    }
  }

  Future<void> decreaseSparePartCount(String model, int decrement) async {
    SparepartsModel? existingItem = dbFunctions.getSparePart(model);

    if (existingItem != null) {
      if (existingItem.count >= decrement) {
        existingItem.count -= decrement;
        await dbFunctions.updateSparePart(model, existingItem);
        print(
            ' Decreased ${existingItem.model} count: New Count = ${existingItem.count}');
        loadAllData();
        notifyListeners();
      } else {
        print(
            ' Not enough stock for ${existingItem.model}. Current count: ${existingItem.count}, Requested: $decrement');
      }
    } else {
      print(' Spare part with model $model not found!');
    }
  }

  void loadAllData() {
    _allSpareParts = getAllSpareParts();
    _filteredSpareParts = _allSpareParts;
    print(
        ' Loaded ${_allSpareParts.length} spare parts into filteredSpareParts');
    notifyListeners();
  }

  bool isSearching = false;
  void setIsSearching(bool value) {
    isSearching = value;
    notifyListeners();
  }

  Future<void> editSpareParts({
    required String currentModel,
    String? model,
    String? category,
    String? location,
    int? price,
    int? count,
    String? extra1,
    String? extra2,
    String? img,
  }) async {
    SparepartsModel? existingItem = dbFunctions.getSparePart(currentModel);

    if (existingItem != null) {
      SparepartsModel updatedItem = SparepartsModel(
        category: category ?? existingItem.category,
        model: model ?? existingItem.model,
        location: location ?? existingItem.location,
        price: price ?? existingItem.price,
        count: count ?? existingItem.count,
        extra1: extra1 ?? existingItem.extra1,
        extra2: extra2 ?? existingItem.extra2,
        img: img ?? existingItem.img,
      );

      if (model != null && model != currentModel) {
        await dbFunctions.deleteSparePart(currentModel);
        await dbFunctions.addSparePart(updatedItem, model);
        print(' Edited and moved ${currentModel} to new model ${model}');
      } else {
        await dbFunctions.updateSparePart(currentModel, updatedItem);
        print(' Edited ${currentModel} successfully');
      }

      loadAllData();
      notifyListeners();
    } else {
      print(' Spare part with model $currentModel not found for editing!');
    }
  }

  Future<void> deleteSpareParts(String model) async {
    final SparepartsModel? existingItem = dbFunctions.getSparePart(model);

    if (existingItem != null) {
      await dbFunctions.deleteSparePart(model);
      print(' Deleted spare part with model: $model');
      loadAllData();
      notifyListeners();
    } else {
      print(' Spare part with model $model not found for deletion!');
    }
  }
}