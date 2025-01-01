// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationRM _$NotificationRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'NotificationRM',
      json,
      ($checkedConvert) {
        final val = NotificationRM(
          id: $checkedConvert('notification_id', (v) => v as String),
          serviceRequestId:
              $checkedConvert('service_request_id', (v) => v as String?),
          disputeId: $checkedConvert('dispute_id', (v) => v as String?),
          type: $checkedConvert('type', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'id': 'notification_id',
        'serviceRequestId': 'service_request_id',
        'disputeId': 'dispute_id'
      },
    );
