// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locale_preference_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalePreferenceCMAdapter extends TypeAdapter<LocalePreferenceCM> {
  @override
  final int typeId = 23;

  @override
  LocalePreferenceCM read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LocalePreferenceCM.english;
      case 1:
        return LocalePreferenceCM.arabic;
      default:
        return LocalePreferenceCM.english;
    }
  }

  @override
  void write(BinaryWriter writer, LocalePreferenceCM obj) {
    switch (obj) {
      case LocalePreferenceCM.english:
        writer.writeByte(0);
        break;
      case LocalePreferenceCM.arabic:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalePreferenceCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
