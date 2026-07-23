import 'package:json_annotation/json_annotation.dart';

part 'paymob_top_up_rm.g.dart';

/// Remote model for the `POST /top-up/paymob` response.
@JsonSerializable(createToJson: false)
class PaymobTopUpRM {
  const PaymobTopUpRM({
    this.message,
    this.data,
    required this.checkoutUrl,
    this.clientSecret,
    this.intentionOrderId,
    required this.paymobTransactionId,
    required this.internalTransactionId,
    this.topupRequestStatus,
    this.paymobStatus,
  });

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'data')
  final PaymobTopUpDataRM? data;

  @JsonKey(name: 'checkout_url')
  final String checkoutUrl;

  @JsonKey(name: 'client_secret')
  final String? clientSecret;

  @JsonKey(name: 'intention_order_id', fromJson: _nullableIntFromJson)
  final int? intentionOrderId;

  @JsonKey(name: 'paymob_transaction_id', fromJson: _stringFromJson)
  final String paymobTransactionId;

  @JsonKey(name: 'internal_transaction_id', fromJson: _intFromJson)
  final int internalTransactionId;

  @JsonKey(name: 'topup_request_status')
  final String? topupRequestStatus;

  @JsonKey(name: 'paymob_status')
  final PaymobStatusRM? paymobStatus;

  factory PaymobTopUpRM.fromJson(Map<String, dynamic> json) =>
      _$PaymobTopUpRMFromJson(json);
}

String _stringFromJson(Object? json) => json?.toString() ?? '';

int _intFromJson(Object? json) {
  if (json is int) return json;
  if (json is num) return json.toInt();
  if (json is String) return int.tryParse(json) ?? 0;
  return 0;
}

int? _nullableIntFromJson(Object? json) {
  if (json == null) return null;
  if (json is int) return json;
  if (json is num) return json.toInt();
  if (json is String) return int.tryParse(json);
  return null;
}

@JsonSerializable(createToJson: false)
class PaymobTopUpDataRM {
  const PaymobTopUpDataRM({
    required this.id,
    required this.amount,
    this.issuer,
    this.msisdn,
    this.status,
    required this.transactionId,
  });

  @JsonKey(name: 'id', fromJson: _intFromJson)
  final int id;

  @JsonKey(name: 'amount', fromJson: _stringFromJson)
  final String amount;

  @JsonKey(name: 'issuer')
  final String? issuer;

  @JsonKey(name: 'msisdn')
  final String? msisdn;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'transaction_id', fromJson: _stringFromJson)
  final String transactionId;

  factory PaymobTopUpDataRM.fromJson(Map<String, dynamic> json) =>
      _$PaymobTopUpDataRMFromJson(json);
}

@JsonSerializable(createToJson: false)
class PaymobStatusRM {
  const PaymobStatusRM({
    this.code,
    this.status,
    this.message,
  });

  @JsonKey(name: 'code', fromJson: _nullableIntFromJson)
  final int? code;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'message')
  final String? message;

  factory PaymobStatusRM.fromJson(Map<String, dynamic> json) =>
      _$PaymobStatusRMFromJson(json);
}
