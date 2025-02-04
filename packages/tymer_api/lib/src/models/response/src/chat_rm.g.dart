// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessageRM _$ChatMessageRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ChatMessageRM',
      json,
      ($checkedConvert) {
        final val = ChatMessageRM(
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

ChatRM _$ChatRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ChatRM',
      json,
      ($checkedConvert) {
        final val = ChatRM(
          messages: $checkedConvert(
              'data',
              (v) => (v as List<dynamic>)
                  .map((e) => ChatMessageRM.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {'messages': 'data'},
    );
