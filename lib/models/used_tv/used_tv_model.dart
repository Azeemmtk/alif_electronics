import 'package:hive/hive.dart';
part 'used_tv_model.g.dart';

@HiveType(typeId: 0)
class UsedTvModel {
  @HiveField(0)
  String usedTvId;

  @HiveField(1)
  dynamic imagePath;

  @HiveField(2)
  String brandName;

  @HiveField(3)
  String modelNumber;

  @HiveField(4)
  String details;

  @HiveField(5)
  DateTime purchaseDate;

  @HiveField(6)
  double purchaseRate;

  @HiveField(7)
  double marketPrice;

  @HiveField(8)
  String status;

  @HiveField(9)
  DateTime? soldDate;

  UsedTvModel({
    required this.usedTvId,
    required this.imagePath,
    required this.brandName,
    required this.modelNumber,
    required this.details,
    required this.purchaseDate,
    required this.purchaseRate,
    required this.marketPrice,
    this.status = 'available',
    this.soldDate,
  });
}
