// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceRM _$ServiceRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ServiceRM',
      json,
      ($checkedConvert) {
        final val = ServiceRM(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          type: $checkedConvert('service_type', (v) => v as String),
          details: $checkedConvert('service',
              (v) => ServiceDetailsRM.fromJson(v as Map<String, dynamic>)),
          location: $checkedConvert('service_location',
              (v) => LocationRM.fromJson(v as Map<String, dynamic>)),
          distanceBetweenProviderAndServiceLocation:
              $checkedConvert('service_distance', (v) => v as String),
          totalPrice:
              $checkedConvert('service_total_price', (v) => v as String),
          status: $checkedConvert('status', (v) => v as String),
          createdAt: $checkedConvert('created_at', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'type': 'service_type',
        'details': 'service',
        'location': 'service_location',
        'distanceBetweenProviderAndServiceLocation': 'service_distance',
        'totalPrice': 'service_total_price',
        'createdAt': 'created_at'
      },
    );

ServiceDetailsRM _$ServiceDetailsRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ServiceDetailsRM',
      json,
      ($checkedConvert) {
        final val = ServiceDetailsRM(
          placeName: $checkedConvert('place_name', (v) => v as String),
          placeAddress: $checkedConvert('place_address', (v) => v as String),
          date: $checkedConvert('date', (v) => v as String),
          additionalDetails:
              $checkedConvert('other_details', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'placeName': 'place_name',
        'placeAddress': 'place_address',
        'additionalDetails': 'other_details'
      },
    );
