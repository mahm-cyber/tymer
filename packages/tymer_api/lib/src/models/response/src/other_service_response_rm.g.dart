// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'other_service_response_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtherServiceRM _$OtherServiceRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'OtherServiceRM',
      json,
      ($checkedConvert) {
        final val = OtherServiceRM(
          date: $checkedConvert('date', (v) => v as String?),
          time: $checkedConvert('time', (v) => v as String?),
          additionalNotes:
              $checkedConvert('other_details', (v) => v as String?),
          image: $checkedConvert('attached_image_url', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'additionalNotes': 'other_details',
        'image': 'attached_image_url'
      },
    );
