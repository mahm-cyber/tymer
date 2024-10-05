// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_service_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$RequestServiceRmToJson(RequestServiceRM instance) =>
    <String, dynamic>{
      'type': instance.type,
      'price': instance.price,
      'location': instance.location,
      'details': instance.details,
    };

Map<String, dynamic> _$RequestLocationRMToJson(RequestLocationRM instance) =>
    <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
    };

Map<String, dynamic> _$RequestDetailsRMToJson(RequestDetailsRM instance) =>
    <String, dynamic>{
      'place_name': instance.placeName,
      'place_address': instance.placeAddress,
      'reserved_for': instance.reservedFor,
      'reservation_date': instance.reservationDate,
      'reservation_service_category_id': instance.reservationServiceCategoryId,
    };
