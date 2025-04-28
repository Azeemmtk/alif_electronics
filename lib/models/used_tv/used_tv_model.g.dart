// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'used_tv_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UsedTvModelAdapter extends TypeAdapter<UsedTvModel> {
  @override
  final int typeId = 0;

  @override
  UsedTvModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UsedTvModel(
      usedTvId: fields[0] as String,
      imagePath: fields[1] as dynamic,
      brandName: fields[2] as String,
      modelNumber: fields[3] as String,
      details: fields[4] as String,
      purchaseDate: fields[5] as DateTime,
      purchaseRate: fields[6] as double,
      marketPrice: fields[7] as double,
      status: fields[8] as String,
      soldDate: fields[9] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, UsedTvModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.usedTvId)
      ..writeByte(1)
      ..write(obj.imagePath)
      ..writeByte(2)
      ..write(obj.brandName)
      ..writeByte(3)
      ..write(obj.modelNumber)
      ..writeByte(4)
      ..write(obj.details)
      ..writeByte(5)
      ..write(obj.purchaseDate)
      ..writeByte(6)
      ..write(obj.purchaseRate)
      ..writeByte(7)
      ..write(obj.marketPrice)
      ..writeByte(8)
      ..write(obj.status)
      ..writeByte(9)
      ..write(obj.soldDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsedTvModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
