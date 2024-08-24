// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_users_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppUsersCMAdapter extends TypeAdapter<AppUsersCM> {
  @override
  final int typeId = 6;

  @override
  AppUsersCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppUsersCM(
      list: (fields[0] as List).cast<UserCM>(),
    );
  }

  @override
  void write(BinaryWriter writer, AppUsersCM obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.list);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppUsersCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
