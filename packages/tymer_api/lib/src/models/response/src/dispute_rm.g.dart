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
          createdAt: $checkedConvert('created_at', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'serviceRequestId': 'service_request_id',
        'serviceRequest': 'service_request',
        'resolvedBy': 'resolved_by',
        'reason': 'other_details',
        'createdAt': 'created_at'
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

DisputeMessageRM _$DisputeMessageRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'DisputeMessageRM',
      json,
      ($checkedConvert) {
        final val = DisputeMessageRM(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          senderId: $checkedConvert('sender_id', (v) => (v as num).toInt()),
          senderName: $checkedConvert('sender_name', (v) => v as String),
          content: $checkedConvert('content', (v) => v as String?),
          chatImages: $checkedConvert('chat_images',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          chatRecords: $checkedConvert('chat_records',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          chatDocuments: $checkedConvert('chat_documents',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          readAt: $checkedConvert('read_at', (v) => v as String?),
          createdAt: $checkedConvert('created_at', (v) => v as String),
          updatedAt: $checkedConvert('updated_at', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'senderId': 'sender_id',
        'senderName': 'sender_name',
        'chatImages': 'chat_images',
        'chatRecords': 'chat_records',
        'chatDocuments': 'chat_documents',
        'readAt': 'read_at',
        'createdAt': 'created_at',
        'updatedAt': 'updated_at'
      },
    );

DisputeChatRM _$DisputeChatRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'DisputeChatRM',
      json,
      ($checkedConvert) {
        final val = DisputeChatRM(
          messages: $checkedConvert(
              'data',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      DisputeMessageRM.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {'messages': 'data'},
    );
