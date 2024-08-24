// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_field_type_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomFieldTypeCMAdapter extends TypeAdapter<CustomFieldTypeCM> {
  @override
  final int typeId = 15;

  @override
  CustomFieldTypeCM read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 2:
        return CustomFieldTypeCM.text;
      case 3:
        return CustomFieldTypeCM.textarea;
      case 4:
        return CustomFieldTypeCM.number;
      case 5:
        return CustomFieldTypeCM.date;
      case 6:
        return CustomFieldTypeCM.dateTime;
      case 7:
        return CustomFieldTypeCM.email;
      case 8:
        return CustomFieldTypeCM.tel;
      case 9:
        return CustomFieldTypeCM.select;
      case 10:
        return CustomFieldTypeCM.multiselect;
      case 11:
        return CustomFieldTypeCM.contacts;
      case 12:
        return CustomFieldTypeCM.companies;
      case 13:
        return CustomFieldTypeCM.deals;
      case 14:
        return CustomFieldTypeCM.checkbox;
      case 15:
        return CustomFieldTypeCM.radio;
      default:
        return CustomFieldTypeCM.text;
    }
  }

  @override
  void write(BinaryWriter writer, CustomFieldTypeCM obj) {
    switch (obj) {
      case CustomFieldTypeCM.text:
        writer.writeByte(2);
        break;
      case CustomFieldTypeCM.textarea:
        writer.writeByte(3);
        break;
      case CustomFieldTypeCM.number:
        writer.writeByte(4);
        break;
      case CustomFieldTypeCM.date:
        writer.writeByte(5);
        break;
      case CustomFieldTypeCM.dateTime:
        writer.writeByte(6);
        break;
      case CustomFieldTypeCM.email:
        writer.writeByte(7);
        break;
      case CustomFieldTypeCM.tel:
        writer.writeByte(8);
        break;
      case CustomFieldTypeCM.select:
        writer.writeByte(9);
        break;
      case CustomFieldTypeCM.multiselect:
        writer.writeByte(10);
        break;
      case CustomFieldTypeCM.contacts:
        writer.writeByte(11);
        break;
      case CustomFieldTypeCM.companies:
        writer.writeByte(12);
        break;
      case CustomFieldTypeCM.deals:
        writer.writeByte(13);
        break;
      case CustomFieldTypeCM.checkbox:
        writer.writeByte(14);
        break;
      case CustomFieldTypeCM.radio:
        writer.writeByte(15);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomFieldTypeCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
