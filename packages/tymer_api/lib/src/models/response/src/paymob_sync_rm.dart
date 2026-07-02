import 'package:json_annotation/json_annotation.dart';

part 'paymob_sync_rm.g.dart';

@JsonSerializable(createToJson: false)
class PaymobSyncRM {
  const PaymobSyncRM({
    required this.success,
    required this.message,
    required this.data,
    this.paymobStatus,
  });

  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final PaymobSyncDataRM data;

  @JsonKey(name: 'paymob_status')
  final PaymobSyncStatusRM? paymobStatus;


  factory PaymobSyncRM.fromJson(Map<String, dynamic> json) =>
      _$PaymobSyncRMFromJson(json);
}

@JsonSerializable(createToJson: false)
class PaymobSyncDataRM {
  const PaymobSyncDataRM({
    required this.id,
    required this.status,
    required this.isSuccess,
    required this.amount,
    required this.issuer,
    required this.msisdn,
    required this.transactionId,
    required this.intentionOrderId,
    required this.isCompleted,
    required this.isFailed,
    required this.isPending,
    this.message,
  });

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  @JsonKey(name: 'amount')
  final String amount;

  @JsonKey(name: 'issuer')
  final String issuer;

  @JsonKey(name: 'msisdn')
  final String msisdn;

  @JsonKey(name: 'transaction_id')
  final String transactionId;

  @JsonKey(name: 'intention_order_id')
  final String intentionOrderId;

  @JsonKey(name: 'is_completed')
  final bool isCompleted;

  @JsonKey(name: 'is_failed')
  final bool isFailed;

  @JsonKey(name: 'is_pending')
  final bool isPending;

  @JsonKey(name: 'message')
  final String? message;

  factory PaymobSyncDataRM.fromJson(Map<String, dynamic> json) =>
      _$PaymobSyncDataRMFromJson(json);
}


@JsonSerializable(createToJson: false)
class PaymobSyncStatusRM {
  const PaymobSyncStatusRM({
    required this.success,
    required this.status,
    required this.paymobStatus,
    required this.isSuccess,
    this.note,
  });

  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'paymob_status')
  final String paymobStatus;

  @JsonKey(name: 'is_success')
  final bool isSuccess;

  @JsonKey(name: 'note')
  final String? note;

  factory PaymobSyncStatusRM.fromJson(Map<String, dynamic> json) =>
      _$PaymobSyncStatusRMFromJson(json);
}
