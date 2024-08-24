// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_tasks_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppTasksCMAdapter extends TypeAdapter<AppTasksCM> {
  @override
  final int typeId = 5;

  @override
  AppTasksCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppTasksCM(
      list: (fields[1] as List).cast<TaskCM>(),
    );
  }

  @override
  void write(BinaryWriter writer, AppTasksCM obj) {
    writer
      ..writeByte(1)
      ..writeByte(1)
      ..write(obj.list);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppTasksCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
