import 'package:json_annotation/json_annotation.dart';

part 'payment_rm.g.dart';

@JsonSerializable(createToJson: false)
class PaymentRM {
  const PaymentRM({
    required this.id,
    required this.userId,
    required this.amount,
    this.ibanNumber,
    this.beneficiaryName,
    this.instantPaymentAddress,
    this.walletNumber,
    required this.status,
    this.proofImage,
    required this.updatedAt,
  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'amount')
  final String amount;
  @JsonKey(name: 'iban_number')
  final String? ibanNumber;
  @JsonKey(name: 'beneficiary_name')
  final String? beneficiaryName;
  @JsonKey(name: 'instant_payment_address')
  final String? instantPaymentAddress;
  @JsonKey(name: 'wallet_number')
  final String? walletNumber;
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'proof_image')
  final String? proofImage;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  factory PaymentRM.fromJson(Map<String, dynamic> json) =>
      _$PaymentRMFromJson(json);
}

@JsonSerializable(createToJson: false)
class PaymentListPageRM {
  PaymentListPageRM({
    required this.list,
    this.isLastPage,
  });

  @JsonKey(name: 'data')
  final List<PaymentRM> list;
  @JsonKey(includeFromJson: false)
  bool? isLastPage;

  static const fromJson = _$PaymentListPageRMFromJson;
} 