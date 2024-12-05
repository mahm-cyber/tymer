// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_rm.dart';

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
          records: $checkedConvert('chat_records',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          images: $checkedConvert('chat_images',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          documents: $checkedConvert('chat_documents',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          content: $checkedConvert('content', (v) => v as String?),
          createdAt: $checkedConvert('created_at', (v) => v as String),
          updatedAt: $checkedConvert('updated_at', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'senderId': 'sender_id',
        'senderName': 'sender_name',
        'records': 'chat_records',
        'images': 'chat_images',
        'documents': 'chat_documents',
        'createdAt': 'created_at',
        'updatedAt': 'updated_at'
      },
    );
