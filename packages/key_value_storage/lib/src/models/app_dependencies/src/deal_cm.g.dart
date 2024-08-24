// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deal_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DealCMAdapter extends TypeAdapter<DealCM> {
  @override
  final int typeId = 9;

  @override
  DealCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DealCM(
      id: fields[0] as int,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DealCM obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DealCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
