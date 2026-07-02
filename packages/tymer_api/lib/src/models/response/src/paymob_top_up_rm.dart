import 'package:json_annotation/json_annotation.dart';

part 'paymob_top_up_rm.g.dart';

/// Remote model for the `POST /top-up/paymob` response.
@JsonSerializable(createToJson: false)
class PaymobTopUpRM {
  const PaymobTopUpRM({
    required this.message,
    required this.data,
    required this.checkoutUrl,
    required this.clientSecret,
    required this.intentionOrderId,
    required this.paymobTransactionId,
    required this.internalTransactionId,
    required this.topupRequestStatus,
    required this.paymobStatus,
  });

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final PaymobTopUpDataRM data;

  @JsonKey(name: 'checkout_url')
  final String checkoutUrl;

  @JsonKey(name: 'client_secret')
  final String clientSecret;

  @JsonKey(name: 'intention_order_id')
  final int intentionOrderId;

  @JsonKey(name: 'paymob_transaction_id')
  final String paymobTransactionId;

  @JsonKey(name: 'internal_transaction_id')
  final int internalTransactionId;

  @JsonKey(name: 'topup_request_status')
  final String topupRequestStatus;

  @JsonKey(name: 'paymob_status')
  final PaymobStatusRM paymobStatus;

  factory PaymobTopUpRM.fromJson(Map<String, dynamic> json) =>
      _$PaymobTopUpRMFromJson(json);
}

@JsonSerializable(createToJson: false)
class PaymobTopUpDataRM {
  const PaymobTopUpDataRM({
    required this.id,
    required this.amount,
    required this.issuer,
    required this.msisdn,
    required this.status,
    required this.transactionId,
  });

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'amount')
  final String amount;

  @JsonKey(name: 'issuer')
  final String issuer;

  @JsonKey(name: 'msisdn')
  final String msisdn;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'transaction_id')
  final String transactionId;

  factory PaymobTopUpDataRM.fromJson(Map<String, dynamic> json) =>
      _$PaymobTopUpDataRMFromJson(json);
}

@JsonSerializable(createToJson: false)
class PaymobStatusRM {
  const PaymobStatusRM({
    required this.code,
    required this.status,
    required this.message,
  });

  @JsonKey(name: 'code')
  final int code;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'message')
  final String message;

  factory PaymobStatusRM.fromJson(Map<String, dynamic> json) =>
      _$PaymobStatusRMFromJson(json);
}
