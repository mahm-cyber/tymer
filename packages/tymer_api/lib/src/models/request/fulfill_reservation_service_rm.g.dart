// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fulfill_reservation_service_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$FulfillReservationServiceRMToJson(
        FulfillReservationServiceRM instance) =>
    <String, dynamic>{
      'location': instance.location,
      'details': instance.details,
    };

Map<String, dynamic> _$FulfillReservationServiceDetailsRMToJson(
        FulfillReservationServiceDetailsRM instance) =>
    <String, dynamic>{
      'reservation_date': instance.day,
      'reservation_code': instance.code,
      'reservation_time': instance.time,
      if (instance.additionalNotes case final value?) 'other_details': value,
      if (FulfillReservationServiceDetailsRM._uint8ToMultipart(instance.image)
          case final value?)
        'attached_image': value,
    };
