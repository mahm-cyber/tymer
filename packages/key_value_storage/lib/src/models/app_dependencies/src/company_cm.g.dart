// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CompanyCMAdapter extends TypeAdapter<CompanyCM> {
  @override
  final int typeId = 7;

  @override
  CompanyCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompanyCM(
      id: fields[0] as int,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CompanyCM obj) {
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
      other is CompanyCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
