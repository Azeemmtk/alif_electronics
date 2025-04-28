// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spare_parts_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SparepartsModelAdapter extends TypeAdapter<SparepartsModel> {
  @override
  final int typeId = 1;

  @override
  SparepartsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SparepartsModel(
      category: fields[0] as String,
      model: fields[1] as String,
      location: fields[2] as String,
      price: fields[3] as int,
      count: fields[4] as int,
      extra1: fields[5] as String?,
      extra2: fields[6] as String?,
      img: fields[7] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, SparepartsModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.model)
      ..writeByte(2)
      ..write(obj.location)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.count)
      ..writeByte(5)
      ..write(obj.extra1)
      ..writeByte(6)
      ..write(obj.extra2)
      ..writeByte(7)
      ..write(obj.img);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SparepartsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
