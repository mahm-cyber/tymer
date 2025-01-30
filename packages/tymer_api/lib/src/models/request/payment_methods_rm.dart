import 'package:json_annotation/json_annotation.dart';

part 'payment_methods_rm.g.dart';

@JsonSerializable(createToJson: false)
class PaymentMethodsRM {
  const PaymentMethodsRM({
    required this.vodafoneCashEnabled,
    required this.vodafoneCashWalletNumber,
    required this.vodafoneCashMessage,
    required this.orangeCashEnabled,
    required this.orangeCashWalletNumber,
    required this.orangeCashMessage,
    required this.etisalatCashEnabled,
    required this.etisalatCashWalletNumber,
    required this.etisalatCashMessage,
    required this.instapayEnabled,
    required this.instapayInstantPaymentAddress,
    required this.instapayMessage,
    required this.bankTransferEnabled,
    required this.bankTransferBeneficiaryName,
    required this.bankTransferBeneficiaryAddress,
    required this.bankTransferBankName,
    required this.bankTransferBeneficiaryAccountNumber,
    required this.bankTransferIban,
    required this.bankTransferSwiftCode,
    required this.bankTransferMessage,
  });

  @JsonKey(name: 'vodafone_cash_enabled')
  final bool vodafoneCashEnabled;
  @JsonKey(name: 'vodafone_cash_wallet_number')
  final String vodafoneCashWalletNumber;
  @JsonKey(name: 'vodafone_cash_message')
  final Map<String, String> vodafoneCashMessage;

  @JsonKey(name: 'orange_cash_enabled')
  final bool orangeCashEnabled;
  @JsonKey(name: 'orange_cash_wallet_number')
  final String orangeCashWalletNumber;
  @JsonKey(name: 'orange_cash_message')
  final Map<String, String> orangeCashMessage;

  @JsonKey(name: 'etisalat_cash_enabled')
  final bool etisalatCashEnabled;
  @JsonKey(name: 'etisalat_cash_wallet_number')
  final String etisalatCashWalletNumber;
  @JsonKey(name: 'etisalat_cash_message')
  final Map<String, String> etisalatCashMessage;

  @JsonKey(name: 'instapay_enabled')
  final bool instapayEnabled;
  @JsonKey(name: 'instapay_instant_payment_address')
  final String instapayInstantPaymentAddress;
  @JsonKey(name: 'instapay_message')
  final Map<String, String> instapayMessage;

  @JsonKey(name: 'bank_transfer_enabled')
  final bool bankTransferEnabled;
  @JsonKey(name: 'bank_transfer_beneficiary_name')
  final String bankTransferBeneficiaryName;
  @JsonKey(name: 'bank_transfer_beneficiary_address')
  final String bankTransferBeneficiaryAddress;
  @JsonKey(name: 'bank_transfer_bank_name')
  final String bankTransferBankName;
  @JsonKey(name: 'bank_transfer_beneficiary_account_number')
  final String bankTransferBeneficiaryAccountNumber;
  @JsonKey(name: 'bank_transfer_iban')
  final String bankTransferIban;
  @JsonKey(name: 'bank_transfer_swift_code')
  final String bankTransferSwiftCode;
  @JsonKey(name: 'bank_transfer_message')
  final Map<String, String> bankTransferMessage;

  factory PaymentMethodsRM.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodsRMFromJson(json);
}
