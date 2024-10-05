// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_service_type_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReservationServiceTypeCMAdapter
    extends TypeAdapter<ReservationServiceTypeCM> {
  @override
  final int typeId = 2;

  @override
  ReservationServiceTypeCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReservationServiceTypeCM(
      id: fields[0] as int,
      name: fields[1] as NameCM,
    );
  }

  @override
  void write(BinaryWriter writer, ReservationServiceTypeCM obj) {
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
      other is ReservationServiceTypeCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NameCMAdapter extends TypeAdapter<NameCM> {
  @override
  final int typeId = 3;

  @override
  NameCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NameCM(
      ar: fields[0] as String,
      en: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NameCM obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.ar)
      ..writeByte(1)
      ..write(obj.en);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NameCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ReservationServiceTypesCMAdapter
    extends TypeAdapter<ReservationServiceTypesCM> {
  @override
  final int typeId = 4;

  @override
  ReservationServiceTypesCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReservationServiceTypesCM(
      list: (fields[0] as List).cast<ReservationServiceTypeCM>(),
    );
  }

  @override
  void write(BinaryWriter writer, ReservationServiceTypesCM obj) {
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
      other is ReservationServiceTypesCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
