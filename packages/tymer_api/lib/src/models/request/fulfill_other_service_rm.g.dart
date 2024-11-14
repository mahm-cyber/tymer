// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fulfill_other_service_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$FulfillOtherServiceRMToJson(
        FulfillOtherServiceRM instance) =>
    <String, dynamic>{
      'location': instance.location,
      'details': instance.details,
    };

Map<String, dynamic> _$FulfillOtherServiceDetailsRMToJson(
    FulfillOtherServiceDetailsRM instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('date', instance.date);
  writeNotNull('time', instance.time);
  writeNotNull('other_details', instance.additionalNotes);
  writeNotNull('attached_image',
      FulfillOtherServiceDetailsRM._uint8ToMultipart(instance.image));
  return val;
}
