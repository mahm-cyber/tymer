import 'package:json_annotation/json_annotation.dart';

part 'transactions_rm.g.dart';

@JsonSerializable(createToJson: false)
class TransactionRM {
  const TransactionRM({
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

  factory TransactionRM.fromJson(Map<String, dynamic> json) =>
      _$TransactionRMFromJson(json);
}

@JsonSerializable(createToJson: false)
class TransactionListPageRM {
  TransactionListPageRM({
    required this.list,
    this.isLastPage,
  });

  @JsonKey(name: 'data')
  final List<TransactionRM> list;
  @JsonKey(includeFromJson: false)
  bool? isLastPage;

  static const fromJson = _$TransactionListPageRMFromJson;
}
