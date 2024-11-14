// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationRM _$LocationRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'LocationRM',
      json,
      ($checkedConvert) {
        final val = LocationRM(
          type: $checkedConvert('type', (v) => v as String? ?? 'Point'),
          coordinates: $checkedConvert(
              'coordinates',
              (v) => (v as List<dynamic>)
                  .map((e) => (e as num).toDouble())
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$LocationRMToJson(LocationRM instance) =>
    <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
    };
