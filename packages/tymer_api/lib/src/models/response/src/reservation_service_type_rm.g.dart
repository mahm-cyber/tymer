// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_service_type_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationServiceTypeRM _$ReservationServiceTypeRMFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'ReservationServiceTypeRM',
      json,
      ($checkedConvert) {
        final val = ReservationServiceTypeRM(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          name: $checkedConvert(
              'name', (v) => NameRM.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

NameRM _$NameRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'NameRM',
      json,
      ($checkedConvert) {
        final val = NameRM(
          ar: $checkedConvert('ar', (v) => v as String),
          en: $checkedConvert('en', (v) => v as String),
        );
        return val;
      },
    );

ReservationServiceTypesRM _$ReservationServiceTypesRMFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'ReservationServiceTypesRM',
      json,
      ($checkedConvert) {
        final val = ReservationServiceTypesRM(
          list: $checkedConvert(
              'data',
              (v) => (v as List<dynamic>)
                  .map((e) => ReservationServiceTypeRM.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {'list': 'data'},
    );
