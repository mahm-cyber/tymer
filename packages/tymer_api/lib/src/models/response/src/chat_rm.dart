import 'package:json_annotation/json_annotation.dart';

part 'chat_rm.g.dart';

@JsonSerializable(createToJson: false)
class ChatMessageRM {
  ChatMessageRM({
    required this.id,
    required this.senderId,
    required this.senderName,
    this.content,
    required this.chatImages,
    required this.chatRecords,
    required this.chatDocuments,
    this.readAt,
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
  @JsonKey(name: 'chat_images')
  final List<String> chatImages;
  @JsonKey(name: 'chat_records')
  final List<String> chatRecords;
  @JsonKey(name: 'chat_documents')
  final List<String> chatDocuments;
  @JsonKey(name: 'read_at')
  final String? readAt;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  factory ChatMessageRM.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageRMFromJson(json);


}

@JsonSerializable(createToJson: false)
class ChatRM {
  ChatRM({
    required this.messages,
  });

  @JsonKey(name: 'data')
  final List<ChatMessageRM> messages;

  factory ChatRM.fromJson(Map<String, dynamic> json) =>
      _$ChatRMFromJson(json);
}
