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
    ServiceRequestDetailsRM instance) {
  final val = <String, dynamic>{
    'place_name': instance.placeName,
    'place_address': instance.placeAddress,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('reserved_for', instance.reservedFor);
  writeNotNull('reservation_date', instance.reservationDate);
  writeNotNull('date', instance.detailsDate);
  writeNotNull(
      'reservation_service_category_id', instance.reservationServiceCategoryId);
  return val;
}
