// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_companies_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppCompaniesCMAdapter extends TypeAdapter<AppCompaniesCM> {
  @override
  final int typeId = 2;

  @override
  AppCompaniesCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppCompaniesCM(
      list: (fields[0] as List).cast<CompanyCM>(),
    );
  }

  @override
  void write(BinaryWriter writer, AppCompaniesCM obj) {
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
      other is AppCompaniesCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
