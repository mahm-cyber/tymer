// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsCMAdapter extends TypeAdapter<SettingsCM> {
  @override
  final int typeId = 8;

  @override
  SettingsCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingsCM(
      pricing: fields[0] as PricingSettingsCM?,
      termsAndConditions: fields[1] as TermsAndConditionsCM?,
      privacyPolicy: fields[2] as PrivacyPolicyCM?,
      faqs: fields[3] as FaqsCM?,
    );
  }

  @override
  void write(BinaryWriter writer, SettingsCM obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.pricing)
      ..writeByte(1)
      ..write(obj.termsAndConditions)
      ..writeByte(2)
      ..write(obj.privacyPolicy)
      ..writeByte(3)
      ..write(obj.faqs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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

class TermsAndConditionsCMAdapter extends TypeAdapter<TermsAndConditionsCM> {
  @override
  final int typeId = 6;

  @override
  TermsAndConditionsCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TermsAndConditionsCM(
      arHtml: fields[0] as String,
      enHtml: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TermsAndConditionsCM obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.arHtml)
      ..writeByte(1)
      ..write(obj.enHtml);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TermsAndConditionsCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PrivacyPolicyCMAdapter extends TypeAdapter<PrivacyPolicyCM> {
  @override
  final int typeId = 7;

  @override
  PrivacyPolicyCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PrivacyPolicyCM(
      arHtml: fields[0] as String,
      enHtml: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PrivacyPolicyCM obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.arHtml)
      ..writeByte(1)
      ..write(obj.enHtml);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrivacyPolicyCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FaqCMAdapter extends TypeAdapter<FaqCM> {
  @override
  final int typeId = 9;

  @override
  FaqCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FaqCM(
      id: fields[0] as int,
      question: (fields[1] as Map).cast<String, String>(),
      answer: (fields[2] as Map).cast<String, String>(),
    );
  }

  @override
  void write(BinaryWriter writer, FaqCM obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.question)
      ..writeByte(2)
      ..write(obj.answer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FaqCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FaqsCMAdapter extends TypeAdapter<FaqsCM> {
  @override
  final int typeId = 10;

  @override
  FaqsCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FaqsCM(
      list: (fields[0] as List).cast<FaqCM>(),
    );
  }

  @override
  void write(BinaryWriter writer, FaqsCM obj) {
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
      other is FaqsCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
