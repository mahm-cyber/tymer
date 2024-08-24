// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserCMAdapter extends TypeAdapter<UserCM> {
  @override
  final int typeId = 13;

  @override
  UserCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserCM(
      id: fields[0] as int,
      name: fields[1] as String,
      email: fields[2] as String?,
      jobTitle: fields[3] as String?,
      phone: fields[4] as String?,
      companyName: fields[5] as String?,
      companyAddress: fields[6] as String?,
      companyCountry: fields[7] as String?,
      accountName: fields[8] as String?,
      companyDomain: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserCM obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.jobTitle)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.companyName)
      ..writeByte(6)
      ..write(obj.companyAddress)
      ..writeByte(7)
      ..write(obj.companyCountry)
      ..writeByte(8)
      ..write(obj.accountName)
      ..writeByte(9)
      ..write(obj.companyDomain);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
