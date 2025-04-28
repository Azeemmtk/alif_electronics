import 'package:hive/hive.dart';
part 'spare_parts_used.g.dart';

@HiveType(typeId: 3) // Use a unique typeId (assuming WorkModel uses 1)
class SparePartUsage {
  @HiveField(0)
  final String workId;

  @HiveField(1)
  final String type;

  @HiveField(2)
  final String model;

  @HiveField(3)
  final int price;

  @HiveField(4)
  final int count;

  @HiveField(5)
  final double? serviceCharge;

  SparePartUsage({
    required this.workId,
    required this.type,
    required this.model,
    required this.price,
    required this.count,
    this.serviceCharge = 300.0,
  });
}
