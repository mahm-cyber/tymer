// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dispute_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DisputeRM _$DisputeRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'DisputeRM',
      json,
      ($checkedConvert) {
        final val = DisputeRM(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          serviceRequestId:
              $checkedConvert('service_request_id', (v) => (v as num).toInt()),
          serviceRequest: $checkedConvert('service_request',
              (v) => ServiceRM.fromJson(v as Map<String, dynamic>)),
          status: $checkedConvert('status', (v) => v as String),
          resolvedBy:
              $checkedConvert('resolved_by', (v) => (v as num?)?.toInt()),
          reason: $checkedConvert('other_details', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'serviceRequestId': 'service_request_id',
        'serviceRequest': 'service_request',
        'resolvedBy': 'resolved_by',
        'reason': 'other_details'
      },
    );

DisputeListPageRM _$DisputeListPageRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'DisputeListPageRM',
      json,
      ($checkedConvert) {
        final val = DisputeListPageRM(
          list: $checkedConvert(
              'data',
              (v) => (v as List<dynamic>)
                  .map((e) => DisputeRM.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {'list': 'data'},
    );
