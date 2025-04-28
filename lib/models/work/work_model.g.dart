// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkModelAdapter extends TypeAdapter<WorkModel> {
  @override
  final int typeId = 2;

  @override
  WorkModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkModel(
      workId: fields[0] as String,
      customerName: fields[1] as String,
      phoneNumber: fields[2] as String,
      brandName: fields[3] as String,
      modelNumber: fields[4] as String,
      complaint: fields[5] as String,
      expectedAmount: fields[6] as String,
      advancePaid: fields[7] as String,
      expectedDate: fields[8] as DateTime,
      imagePath: fields[9] as dynamic,
      status: fields[10] as String,
      paymentStatus: fields[11] as String,
      cancellationReason: fields[12] as String,
      finalAmount: fields[13] as double,
    );
  }

  @override
  void write(BinaryWriter writer, WorkModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.workId)
      ..writeByte(1)
      ..write(obj.customerName)
      ..writeByte(2)
      ..write(obj.phoneNumber)
      ..writeByte(3)
      ..write(obj.brandName)
      ..writeByte(4)
      ..write(obj.modelNumber)
      ..writeByte(5)
      ..write(obj.complaint)
      ..writeByte(6)
      ..write(obj.expectedAmount)
      ..writeByte(7)
      ..write(obj.advancePaid)
      ..writeByte(8)
      ..write(obj.expectedDate)
      ..writeByte(9)
      ..write(obj.imagePath)
      ..writeByte(10)
      ..write(obj.status)
      ..writeByte(11)
      ..write(obj.paymentStatus)
      ..writeByte(12)
      ..write(obj.cancellationReason)
      ..writeByte(13)
      ..write(obj.finalAmount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
