// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_deals_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppDealsCMAdapter extends TypeAdapter<AppDealsCM> {
  @override
  final int typeId = 4;

  @override
  AppDealsCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppDealsCM(
      list: (fields[2] as List).cast<DealCM>(),
    );
  }

  @override
  void write(BinaryWriter writer, AppDealsCM obj) {
    writer
      ..writeByte(1)
      ..writeByte(2)
      ..write(obj.list);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppDealsCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
