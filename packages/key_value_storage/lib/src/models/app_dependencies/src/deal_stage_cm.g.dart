// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deal_stage_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DealStageCMAdapter extends TypeAdapter<DealStageCM> {
  @override
  final int typeId = 11;

  @override
  DealStageCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DealStageCM(
      id: fields[0] as int,
      name: fields[1] as String,
      color: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DealStageCM obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DealStageCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
