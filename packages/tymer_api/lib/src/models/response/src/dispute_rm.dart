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
