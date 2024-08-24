// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_contacts_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppContactsCMAdapter extends TypeAdapter<AppContactsCM> {
  @override
  final int typeId = 3;

  @override
  AppContactsCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppContactsCM(
      list: (fields[3] as List).cast<ContactCM>(),
    );
  }

  @override
  void write(BinaryWriter writer, AppContactsCM obj) {
    writer
      ..writeByte(1)
      ..writeByte(3)
      ..write(obj.list);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppContactsCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
