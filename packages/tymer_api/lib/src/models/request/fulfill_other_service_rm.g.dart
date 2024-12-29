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
        FulfillOtherServiceDetailsRM instance) =>
    <String, dynamic>{
      if (instance.date case final value?) 'date': value,
      if (instance.time case final value?) 'time': value,
      if (instance.additionalNotes case final value?) 'other_details': value,
      if (FulfillOtherServiceDetailsRM._uint8ToMultipart(instance.image)
          case final value?)
        'attached_image': value,
    };
