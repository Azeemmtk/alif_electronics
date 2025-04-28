import 'package:hive/hive.dart';

part 'work_model.g.dart';

@HiveType(typeId: 2)
class WorkModel {
  @HiveField(0)
  String workId;

  @HiveField(1)
  String customerName;

  @HiveField(2)
  String phoneNumber;

  @HiveField(3)
  String brandName;

  @HiveField(4)
  String modelNumber;

  @HiveField(5)
  String complaint;

  @HiveField(6)
  String expectedAmount;

  @HiveField(7)
  String advancePaid;

  @HiveField(8)
  DateTime expectedDate;

  @HiveField(9)
  dynamic imagePath;

  @HiveField(10)
  String status;

  @HiveField(11)
  String paymentStatus;

  @HiveField(12)
  String cancellationReason;

  @HiveField(13)
  double finalAmount;

  WorkModel({
    required this.workId,
    required this.customerName,
    required this.phoneNumber,
    required this.brandName,
    required this.modelNumber,
    required this.complaint,
    required this.expectedAmount,
    required this.advancePaid,
    required this.expectedDate,
    this.imagePath,
    this.status = 'Pending',
    this.paymentStatus = 'Pending',
    this.cancellationReason = 'Not Cancelled',
    this.finalAmount = 0.0,
  });
}
