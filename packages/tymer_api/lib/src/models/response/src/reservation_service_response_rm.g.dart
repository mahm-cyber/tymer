// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_service_response_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationServiceRM _$ReservationServiceRMFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'ReservationServiceRM',
      json,
      ($checkedConvert) {
        final val = ReservationServiceRM(
          date: $checkedConvert('reservation_date', (v) => v as String),
          code: $checkedConvert('reservation_code', (v) => v as String),
          time: $checkedConvert('reservation_time', (v) => v as String),
          additionalNotes:
              $checkedConvert('other_details', (v) => v as String?),
          image: $checkedConvert('attached_image_url', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'date': 'reservation_date',
        'code': 'reservation_code',
        'time': 'reservation_time',
        'additionalNotes': 'other_details',
        'image': 'attached_image_url'
      },
    );
