import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:alif_electronics/db_functions.dart';
import 'package:alif_electronics/models/spare_parts_used/spare_parts_used.dart';
import 'package:alif_electronics/models/work/work_model.dart';
import 'package:alif_electronics/widgets/image_picker_widget.dart';

class WorkProvider extends ChangeNotifier {
  final DbFunctions dbFunctions = DbFunctions();

  int selectedTab = 0;
  DateTime? selectedDate;
  int totalWorks = 0;
  File? imageFile; // For mobile
  Uint8List? webImageBytes; // For web

  List<WorkModel> pendingWork = [];
  List<WorkModel> inProgressWork = [];
  List<WorkModel> completedWork = [];
  List<WorkModel> cancelledWork = [];
  List<SparePartUsage> sparePartsUsed = [];

  double get totalAllSparePartsUsedValue => dbFunctions.getTotalSparePartsUsedValue();

  WorkProvider() {
    getAllWork();
  }

  void changeTab(int number) {
    selectedTab = number;
    notifyListeners();
  }

  Future<void> selectDate(BuildContext context) async {
    try {
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
    } catch (e) {
      print('Error selecting date: $e');
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

  String generateWorkId() {
    int count = dbFunctions.getAllWorks().length + 1;
    return "W${count.toString().padLeft(3, '0')}";
  }

  Future<void> saveWork({
    required String customerName,
    required String phoneNumber,
    required String brandName,
    required String modelNumber,
    required String complaint,
    required String expectedAmount,
    required String advancePaid,
  }) async {
    if ((kIsWeb && webImageBytes == null) || (!kIsWeb && imageFile == null) || selectedDate == null) {
      print('Missing required fields: image or date');
      return;
    }

    final work = WorkModel(
      workId: generateWorkId(),
      customerName: customerName,
      phoneNumber: phoneNumber,
      brandName: brandName,
      modelNumber: modelNumber,
      complaint: complaint,
      expectedAmount: expectedAmount,
      advancePaid: advancePaid,
      expectedDate: selectedDate!,
      imagePath: kIsWeb ? webImageBytes!.toList() : imageFile!.path,
      status: "Pending",
      paymentStatus: 'Pending',
      cancellationReason: 'Not Cancelled',
      finalAmount: 0.0,
    );

    try {
      await dbFunctions.addWork(work);
      print(
          'Saved work: ${work.workId}, PaymentStatus: ${work.paymentStatus}, CancelReason: ${work.cancellationReason}');
      selectedDate = null;
      imageFile = null;
      webImageBytes = null;
      getAllWork();
      notifyListeners();
    } catch (e) {
      print('Error saving work: $e');
    }
  }

  Future<void> addCancellationReason({
    required String workId,
    required String cancellationReason,
  }) async {
    final index = dbFunctions.getAllWorks().indexWhere((work) => work.workId == workId);

    if (index != -1) {
      final existingWork = dbFunctions.getWorkAtIndex(index);

      if (existingWork != null) {
        final updatedWork = WorkModel(
          customerName: existingWork.customerName,
          phoneNumber: existingWork.phoneNumber,
          brandName: existingWork.brandName,
          modelNumber: existingWork.modelNumber,
          complaint: existingWork.complaint,
          expectedAmount: existingWork.expectedAmount,
          advancePaid: existingWork.advancePaid,
          expectedDate: existingWork.expectedDate,
          imagePath: existingWork.imagePath,
          status: existingWork.status,
          workId: existingWork.workId,
          paymentStatus: existingWork.paymentStatus,
          cancellationReason: cancellationReason,
          finalAmount: existingWork.finalAmount,
        );

        await dbFunctions.updateWork(index, updatedWork);
        print(
            'Cancellation reason added: $cancellationReason for Work ID: $workId');

        getAllWork();
        notifyListeners();
      }
    } else {
      print('Invalid workId: $workId');
    }
  }

  void getAllWork() {
    pendingWork.clear();
    inProgressWork.clear();
    completedWork.clear();
    cancelledWork.clear();

    for (var work in dbFunctions.getAllWorks()) {
      if (work.status == "Pending" &&
          work.cancellationReason == "Not Cancelled") {
        pendingWork.add(work);
      } else if (work.status == "In Progress" &&
          work.cancellationReason == "Not Cancelled") {
        inProgressWork.add(work);
      } else if (work.status == "Completed" &&
          work.cancellationReason == "Not Cancelled") {
        completedWork.add(work);
      }

      if (work.cancellationReason != "Not Cancelled") {
        cancelledWork.add(work);
      }
    }

    totalWorks =
        pendingWork.length + inProgressWork.length + completedWork.length;

    print(
        "Work categorized: Pending (${pendingWork.length}), In Progress (${inProgressWork.length}), Completed (${completedWork.length}), Cancelled (${cancelledWork.length})");
    notifyListeners();
  }

  Future<void> updateWorkStatus({
    required String workId,
    required String newStatus,
  }) async {
    final index = dbFunctions.getAllWorks().indexWhere(
          (work) => work.workId == workId,
    );

    if (index != -1) {
      final existingWork = dbFunctions.getWorkAtIndex(index);

      if (existingWork != null) {
        final updatedWork = WorkModel(
          customerName: existingWork.customerName,
          phoneNumber: existingWork.phoneNumber,
          brandName: existingWork.brandName,
          modelNumber: existingWork.modelNumber,
          complaint: existingWork.complaint,
          expectedAmount: existingWork.expectedAmount,
          advancePaid: existingWork.advancePaid,
          expectedDate: newStatus == 'Completed'
              ? DateTime.now()
              : existingWork.expectedDate,
          imagePath: existingWork.imagePath,
          status: newStatus,
          workId: existingWork.workId,
          paymentStatus: existingWork.paymentStatus,
          cancellationReason: existingWork.cancellationReason,
          finalAmount: existingWork.finalAmount,
        );

        await dbFunctions.updateWork(index, updatedWork);
        print('Work status updated at index $index -> $newStatus');

        getAllWork();
        notifyListeners();
      }
    } else {
      print('Invalid workId: $workId');
    }
  }

  Future<void> updateWorkData({
    required String workId,
    String? customerName,
    String? phoneNumber,
    String? brandName,
    String? modelNumber,
    String? complaint,
    String? expectedAmount,
    String? advancePaid,
    DateTime? expectedDate,
    dynamic imagePath, // Updated to dynamic
  }) async {
    final index = dbFunctions.getAllWorks().indexWhere((work) => work.workId == workId);
    if (index != -1) {
      final existingWork = dbFunctions.getWorkAtIndex(index);

      if (existingWork != null) {
        final updatedWork = WorkModel(
          customerName: customerName ?? existingWork.customerName,
          phoneNumber: phoneNumber ?? existingWork.phoneNumber,
          brandName: brandName ?? existingWork.brandName,
          modelNumber: modelNumber ?? existingWork.modelNumber,
          complaint: complaint ?? existingWork.complaint,
          expectedAmount: expectedAmount ?? existingWork.expectedAmount,
          advancePaid: advancePaid ?? existingWork.advancePaid,
          expectedDate: expectedDate ?? existingWork.expectedDate,
          imagePath: imagePath ?? existingWork.imagePath,
          status: existingWork.status,
          workId: existingWork.workId,
          paymentStatus: existingWork.paymentStatus,
          cancellationReason: existingWork.cancellationReason,
          finalAmount: existingWork.finalAmount,
        );

        await dbFunctions.updateWork(index, updatedWork);
        print('Work data updated at index $index');

        getAllWork();
        notifyListeners();
      }
    } else {
      print('Invalid workId: $workId');
    }
  }

  Future<void> deleteWork({required String workId}) async {
    final index = dbFunctions.getAllWorks().indexWhere((work) => work.workId == workId);

    if (index != -1) {
      await dbFunctions.deleteWork(index);
      print('Work deleted successfully: Work ID $workId at index $index');

      getAllWork();
      notifyListeners();
    } else {
      print('Invalid workId');
    }
  }

  double get totalFinalAmount {
    final now = DateTime.now();
    final currentMonth = now.month;
    final currentYear = now.year;

    return dbFunctions.getAllWorks()
        .where(
          (data) =>
      data.expectedDate.month == currentMonth &&
          data.expectedDate.year == currentYear,
    )
        .fold(0.0, (sum, work) => sum + work.finalAmount);
  }

  int get currentMonthCompletedWorkCount {
    final now = DateTime.now();
    final currentMonth = now.month;
    final currentYear = now.year;

    return completedWork
        .where((work) =>
    work.expectedDate.month == currentMonth &&
        work.expectedDate.year == currentYear)
        .length;
  }

  int get currentMonthPendingWorkCount {
    final now = DateTime.now();
    final currentMonth = now.month;
    final currentYear = now.year;

    return pendingWork
        .where((work) =>
    work.expectedDate.month == currentMonth &&
        work.expectedDate.year == currentYear)
        .length;
  }

  int get currentMonthInProgressWorkCount {
    final now = DateTime.now();
    final currentMonth = now.month;
    final currentYear = now.year;

    return inProgressWork
        .where((work) =>
    work.expectedDate.month == currentMonth &&
        work.expectedDate.year == currentYear)
        .length;
  }

  int get currentMonthCancelledWorkCount {
    final now = DateTime.now();
    final currentMonth = now.month;
    final currentYear = now.year;

    return cancelledWork
        .where((work) =>
    work.expectedDate.month == currentMonth &&
        work.expectedDate.year == currentYear)
        .length;
  }

  Future<void> updatePaymentStatus({
    required String workId,
    required String paymentStatus,
    required double totalAmount,
  }) async {
    final index = dbFunctions.getAllWorks().indexWhere((work) => work.workId == workId);

    if (index != -1) {
      final existingWork = dbFunctions.getWorkAtIndex(index);

      if (existingWork != null) {
        final updatedWork = WorkModel(
          customerName: existingWork.customerName,
          phoneNumber: existingWork.phoneNumber,
          brandName: existingWork.brandName,
          modelNumber: existingWork.modelNumber,
          complaint: existingWork.complaint,
          expectedAmount: existingWork.expectedAmount,
          advancePaid: existingWork.advancePaid,
          expectedDate: existingWork.expectedDate,
          imagePath: existingWork.imagePath,
          status: existingWork.status,
          workId: existingWork.workId,
          paymentStatus: paymentStatus,
          cancellationReason: existingWork.cancellationReason,
          finalAmount: totalAmount,
        );

        await dbFunctions.updateWork(index, updatedWork);
        print('Payment status updated to $paymentStatus for Work ID: $workId');

        getAllWork();
        notifyListeners();
      }
    } else {
      print('Invalid workId: $workId');
    }
  }

  Future<void> saveSparePartsUsage(
      String workId, List<Map<String, dynamic>> parts) async {
    print('Attempting to save spare parts for Work ID: $workId');
    print('Parts to save: $parts');
    if (parts.isEmpty) {
      print('No parts provided to save');
      return;
    }
    for (var part in parts) {
      print('Saving part: $part');
      final usage = SparePartUsage(
        workId: workId,
        type: part['type'] as String,
        model: part['model'] as String,
        price: part['price'] as int,
        count: part['count'] as int,
        serviceCharge: (part['serviceCharge'] as num?)?.toDouble() ?? 300.0,
      );
      await dbFunctions.addSparePartUsage(usage);
      print(
          'Saved used spare part: ${usage.type}, ${usage.model}, ${usage.price}, ${usage.count}, ServiceCharge: ${usage.serviceCharge}');
    }
    print('All used spare parts saved successfully');
    notifyListeners();
  }

  List<SparePartUsage> getSparePartsForWork(String workId) {
    sparePartsUsed = dbFunctions.getSparePartsForWork(workId);
    print(
        'Spare parts fetched for Work ID: $workId, Count: ${sparePartsUsed.length}');
    for (var part in sparePartsUsed) {
      print(
          'Part: ${part.model}, ServiceCharge: ${part.serviceCharge ?? 'null'}');
    }
    notifyListeners();
    return sparePartsUsed;
  }
}