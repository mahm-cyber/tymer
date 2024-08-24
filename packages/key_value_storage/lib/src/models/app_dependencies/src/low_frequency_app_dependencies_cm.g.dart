// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'low_frequency_app_dependencies_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LowFrequencyAppDependenciesCMAdapter
    extends TypeAdapter<LowFrequencyAppDependenciesCM> {
  @override
  final int typeId = 10;

  @override
  LowFrequencyAppDependenciesCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LowFrequencyAppDependenciesCM(
      jobTitles: (fields[0] as List).cast<String>(),
      stages: (fields[1] as List).cast<DealStageCM>(),
      priorities: (fields[2] as List).cast<String>(),
      lifeCycles: fields[3] as LifeCyclesCM,
      status: (fields[4] as List).cast<String>(),
      contactCustomFields: (fields[5] as List).cast<CustomFieldCM>(),
      dealCustomFields: (fields[6] as List).cast<CustomFieldCM>(),
      companyCustomFields: (fields[7] as List).cast<CustomFieldCM>(),
    );
  }

  @override
  void write(BinaryWriter writer, LowFrequencyAppDependenciesCM obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.jobTitles)
      ..writeByte(1)
      ..write(obj.stages)
      ..writeByte(2)
      ..write(obj.priorities)
      ..writeByte(3)
      ..write(obj.lifeCycles)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.contactCustomFields)
      ..writeByte(6)
      ..write(obj.dealCustomFields)
      ..writeByte(7)
      ..write(obj.companyCustomFields);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LowFrequencyAppDependenciesCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
