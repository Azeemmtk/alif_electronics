import 'package:hive_flutter/adapters.dart';
part 'spare_parts_model.g.dart';

@HiveType(typeId: 1)
class SparepartsModel {
  @HiveField(0)
  String category;

  @HiveField(1)
  String model;

  @HiveField(2)
  String location;

  @HiveField(3)
  int price;

  @HiveField(4)
  int count;

  @HiveField(5)
  String? extra1;

  @HiveField(6)
  String? extra2;

  @HiveField(7)
  dynamic img;

  SparepartsModel(
      {required this.category,
      required this.model,
      required this.location,
      required this.price,
      required this.count,
      this.extra1,
      this.extra2,
      this.img});
}
