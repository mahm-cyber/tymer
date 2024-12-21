import 'package:json_annotation/json_annotation.dart';
import 'package:tymer_api/src/models/models.dart';

part 'dispute_rm.g.dart';

@JsonSerializable(createToJson: false)
class DisputeRM {
  const DisputeRM({
    required this.id,
    required this.serviceRequestId,
    required this.serviceRequest,
    required this.status,
    this.resolvedBy,
    required this.reason,
  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'service_request_id')
  final int serviceRequestId;
  @JsonKey(name: 'service_request')
  final ServiceRM serviceRequest;
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'resolved_by')
  final int? resolvedBy;
  @JsonKey(name: 'other_details')
  final String? reason;

  factory DisputeRM.fromJson(Map<String, dynamic> json) =>
      _$DisputeRMFromJson(json);
}

@JsonSerializable(createToJson: false)
class DisputeListPageRM {
  DisputeListPageRM({
    required this.list,
    this.isLastPage = false,
  });

  @JsonKey(name: 'data')
  final List<DisputeRM> list;
  @JsonKey(includeFromJson: false)
  bool isLastPage;

  static const fromJson = _$DisputeListPageRMFromJson;
}

@JsonSerializable(createToJson: false)
class DisputeMessageRM {
  DisputeMessageRM({
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

  factory DisputeMessageRM.fromJson(Map<String, dynamic> json) =>
      _$DisputeMessageRMFromJson(json);

  static DisputeMessageRM get dummy => DisputeMessageRM(
        id: -1,
        senderId: -1,
        senderName: '',
        content: '',
        chatImages: [],
        chatRecords: [],
        chatDocuments: [],
        readAt: '2024-12-21T12:36:45.000000Z',
        createdAt: '2024-12-21T12:36:45.000000Z',
        updatedAt: '2024-12-21T12:36:45.000000Z',
      );
}

@JsonSerializable(createToJson: false)
class DisputeChatRM {
  DisputeChatRM({
    required this.messages,
  });

  @JsonKey(name: 'data')
  final List<DisputeMessageRM> messages;

  factory DisputeChatRM.fromJson(Map<String, dynamic> json) =>
      _$DisputeChatRMFromJson(json);
}
