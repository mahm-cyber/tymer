// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_field_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomFieldCMAdapter extends TypeAdapter<CustomFieldCM> {
  @override
  final int typeId = 14;

  @override
  CustomFieldCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomFieldCM(
      id: fields[0] as int,
      label: fields[1] as String,
      name: fields[2] as String,
      type: fields[3] as CustomFieldTypeCM,
      choices: (fields[4] as List).cast<String>(),
      isRequired: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CustomFieldCM obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.label)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.choices)
      ..writeByte(5)
      ..write(obj.isRequired);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomFieldCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
