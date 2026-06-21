import 'package:json_annotation/json_annotation.dart';

part 'paymob_top_up_rm.g.dart';

/// Remote model for the `POST /top-up/paymob` response.
///
/// ```json
/// {
///   "success": true,
///   "message": "Payment intention created successfully",
///   "data": {
///     "transaction_id": 91,
///     "amount": "50.00",
///     "issuer": "vodafone",
///     "msisdn": "01023456789",
///     "status": "pending_payment",
///     "checkout_url": "https://accept.paymob.com/...",
///     "client_secret": "egy_csk_test_...",
///     "intention_order_id": 550620883,
///     "paymob_transaction_id": "pi_test_..."
///   },
///   "topup_request_status": "pending_payment",
///   "paymob_status": { "code": 200, "status": "pending_payment", "message": "..." }
/// }
/// ```
@JsonSerializable(createToJson: false)
class PaymobTopUpRM {
  const PaymobTopUpRM({
    required this.success,
    required this.message,
    required this.data,
    required this.topupRequestStatus,
    required this.paymobStatus,
  });

  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final PaymobTopUpDataRM data;

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
    required this.transactionId,
    required this.amount,
    required this.issuer,
    required this.msisdn,
    required this.status,
    required this.checkoutUrl,
    required this.clientSecret,
    required this.intentionOrderId,
    required this.paymobTransactionId,
  });

  @JsonKey(name: 'transaction_id')
  final int transactionId;

  @JsonKey(name: 'amount')
  final num amount;

  @JsonKey(name: 'issuer')
  final String issuer;

  @JsonKey(name: 'msisdn')
  final String msisdn;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'checkout_url')
  final String checkoutUrl;

  @JsonKey(name: 'client_secret')
  final String clientSecret;

  @JsonKey(name: 'intention_order_id')
  final int intentionOrderId;

  @JsonKey(name: 'paymob_transaction_id')
  final String paymobTransactionId;

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
