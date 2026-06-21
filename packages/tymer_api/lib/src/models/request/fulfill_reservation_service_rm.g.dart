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
    FulfillReservationServiceDetailsRM instance) {
  final val = <String, dynamic>{
    'reservation_date': instance.day,
    'reservation_code': instance.code,
    'reservation_time': instance.time,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('other_details', instance.additionalNotes);
  writeNotNull('attached_image',
      FulfillReservationServiceDetailsRM._uint8ToMultipart(instance.image));
  return val;
}
