// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pricing_settings_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PricingSettingsCMAdapter extends TypeAdapter<PricingSettingsCM> {
  @override
  final int typeId = 5;

  @override
  PricingSettingsCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PricingSettingsCM(
      reservationServiceMinPrice: fields[0] as int,
      reservationServiceFee: fields[1] as int,
      reservationServiceFeeType: fields[2] as String,
      otherServiceMinPrice: fields[3] as int,
      otherServiceFee: fields[4] as int,
      otherServiceFeeType: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PricingSettingsCM obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.reservationServiceMinPrice)
      ..writeByte(1)
      ..write(obj.reservationServiceFee)
      ..writeByte(2)
      ..write(obj.reservationServiceFeeType)
      ..writeByte(3)
      ..write(obj.otherServiceMinPrice)
      ..writeByte(4)
      ..write(obj.otherServiceFee)
      ..writeByte(5)
      ..write(obj.otherServiceFeeType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PricingSettingsCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
