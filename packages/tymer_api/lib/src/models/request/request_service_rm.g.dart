// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_service_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$RequestServiceRMToJson(RequestServiceRM instance) =>
    <String, dynamic>{
      'type': instance.type,
      'price': instance.price,
      'location': instance.location,
      'details': instance.details,
    };

Map<String, dynamic> _$ServiceRequestDetailsRMToJson(
        ServiceRequestDetailsRM instance) =>
    <String, dynamic>{
      'place_name': instance.placeName,
      'place_address': instance.placeAddress,
      if (instance.reservedFor case final value?) 'reserved_for': value,
      if (instance.reservationDate case final value?) 'reservation_date': value,
      if (instance.reservationTime case final value?) 'reservation_time': value,
      if (instance.detailsDate case final value?) 'date': value,
      if (instance.detailsTime case final value?) 'time': value,
      if (instance.reservationServiceCategoryId case final value?)
        'reservation_service_category_id': value,
      if (instance.additionalComments case final value?) 'other_details': value,
    };
