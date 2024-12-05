import 'package:json_annotation/json_annotation.dart';

part 'chat_message_rm.g.dart';

@JsonSerializable(createToJson: false)
class ChatMessageRM {
  const ChatMessageRM({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.records,
    required this.images,
    required this.documents,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'sender_id')
  final int senderId;
  @JsonKey(name: 'sender_name')
  final String senderName;
  @JsonKey(name: 'content')
  final String? content;
  @JsonKey(name: 'chat_records')
  final List<String> records;
  @JsonKey(name: 'chat_images')
  final List<String> images;
  @JsonKey(name: 'chat_documents')
  final List<String> documents;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  factory ChatMessageRM.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageRMFromJson(json);
}