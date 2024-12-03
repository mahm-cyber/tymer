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
          details: $checkedConvert(
              'service',
              (v) => v == null
                  ? null
                  : ServiceDetailsRM.fromJson(v as Map<String, dynamic>)),
          location: $checkedConvert('service_location',
              (v) => LocationRM.fromJson(v as Map<String, dynamic>)),
          distanceBetweenProviderAndServiceLocation:
              $checkedConvert('service_distance', (v) => v as String?),
          totalPrice:
              $checkedConvert('service_total_price', (v) => v as String),
          status: $checkedConvert('status', (v) => v as String),
          createdAt: $checkedConvert('created_at', (v) => v as String),
          response: $checkedConvert('service_response',
              (v) => ServiceRM._responseFromJson(v as Map<String, dynamic>?)),
        );
        return val;
      },
      fieldKeyMap: const {
        'type': 'service_type',
        'details': 'service',
        'location': 'service_location',
        'distanceBetweenProviderAndServiceLocation': 'service_distance',
        'totalPrice': 'service_total_price',
        'createdAt': 'created_at',
        'response': 'service_response'
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
          date: $checkedConvert('date', (v) => v as String?),
          reservedFor: $checkedConvert('reserved_for', (v) => v as String?),
          reservationDate:
              $checkedConvert('reservation_date', (v) => v as String?),
          reservationTime:
              $checkedConvert('reservation_time', (v) => v as String?),
          reservationServiceCategory: $checkedConvert(
              'reservation_service_category',
              (v) => v == null
                  ? null
                  : ReservationServiceTypeRM.fromJson(
                      v as Map<String, dynamic>)),
          additionalDetails:
              $checkedConvert('other_details', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'placeName': 'place_name',
        'placeAddress': 'place_address',
        'reservedFor': 'reserved_for',
        'reservationDate': 'reservation_date',
        'reservationTime': 'reservation_time',
        'reservationServiceCategory': 'reservation_service_category',
        'additionalDetails': 'other_details'
      },
    );

ServiceListPageRM _$ServiceListPageRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ServiceListPageRM',
      json,
      ($checkedConvert) {
        final val = ServiceListPageRM(
          list: $checkedConvert(
              'data',
              (v) => (v as List<dynamic>)
                  .map((e) => ServiceRM.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {'orderList': 'data'},
    );
