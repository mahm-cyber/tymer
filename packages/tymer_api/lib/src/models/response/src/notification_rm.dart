import 'package:json_annotation/json_annotation.dart';

part 'notification_rm.g.dart';

@JsonSerializable(createToJson: false)
class NotificationRM {
  const NotificationRM({
     this.id,
    this.serviceRequestId,
    this.disputeId,
    required this.type,
  });

  @JsonKey(name: 'notification_id')
  final String? id;
  @JsonKey(name: 'service_request_id')
  final String? serviceRequestId;
  @JsonKey(name: 'dispute_id')
  final String? disputeId;
  @JsonKey(name: 'type')
  final String type;

  factory NotificationRM.fromJson(Map<String, dynamic> json) =>
      _$NotificationRMFromJson(json);
}
