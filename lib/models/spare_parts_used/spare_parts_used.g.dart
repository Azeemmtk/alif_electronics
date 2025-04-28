// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spare_parts_used.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SparePartUsageAdapter extends TypeAdapter<SparePartUsage> {
  @override
  final int typeId = 3;

  @override
  SparePartUsage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SparePartUsage(
      workId: fields[0] as String,
      type: fields[1] as String,
      model: fields[2] as String,
      price: fields[3] as int,
      count: fields[4] as int,
      serviceCharge: fields[5] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, SparePartUsage obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.workId)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.model)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.count)
      ..writeByte(5)
      ..write(obj.serviceCharge);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SparePartUsageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
