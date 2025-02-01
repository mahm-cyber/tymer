import 'package:json_annotation/json_annotation.dart';

part 'in_app_transactions_rm.g.dart';


@JsonSerializable(createToJson: false)
class InAppTransactionRM {
  const InAppTransactionRM({
    required this.id,
    required this.userId,
    required this.type,
    required this.status,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'type')
  final String type;
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'amount')
  final String amount;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  factory InAppTransactionRM.fromJson(Map<String, dynamic> json) =>
      _$InAppTransactionRMFromJson(json);
}

@JsonSerializable(createToJson: false)
class InAppTransactionListPageRM {
  InAppTransactionListPageRM({
    required this.list,
    this.isLastPage,
  });

  @JsonKey(name: 'data')
  final List<InAppTransactionRM> list;
  @JsonKey(includeFromJson: false)
  bool? isLastPage;

  static const fromJson = _$InAppTransactionListPageRMFromJson;
}
