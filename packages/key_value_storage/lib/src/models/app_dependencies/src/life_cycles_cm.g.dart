// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'life_cycles_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LifeCyclesCMAdapter extends TypeAdapter<LifeCyclesCM> {
  @override
  final int typeId = 16;

  @override
  LifeCyclesCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LifeCyclesCM(
      contact: (fields[0] as List).cast<String>(),
      company: (fields[1] as List).cast<String>(),
      deal: (fields[2] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, LifeCyclesCM obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.contact)
      ..writeByte(1)
      ..write(obj.company)
      ..writeByte(2)
      ..write(obj.deal);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LifeCyclesCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
