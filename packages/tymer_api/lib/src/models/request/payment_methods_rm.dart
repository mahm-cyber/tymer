import 'package:json_annotation/json_annotation.dart';

part 'payment_methods_rm.g.dart';

@JsonSerializable(createToJson: false)
class PaymentMethodsRM {
  const PaymentMethodsRM({
    this.withdrawMinimumAmount,
    this.cardEnabled = false,
    required this.vodafoneCashEnabled,
    this.vodafoneCashWalletNumber,
    required this.vodafoneCashMessage,
    required this.orangeCashEnabled,
    this.orangeCashWalletNumber,
    required this.orangeCashMessage,
    required this.etisalatCashEnabled,
    this.etisalatCashWalletNumber,
    required this.etisalatCashMessage,
    required this.instapayEnabled,
    this.instapayInstantPaymentAddress,
    required this.instapayMessage,
    required this.teldaEnabled,
    this.teldaUsername,
    required this.teldaMessage,
    required this.bankTransferEnabled,
    this.bankTransferBeneficiaryName,
    this.bankTransferBeneficiaryAddress,
    this.bankTransferBankName,
    this.bankTransferBeneficiaryAccountNumber,
    this.bankTransferIban,
    this.bankTransferSwiftCode,
    required this.bankTransferMessage,
  });
  @JsonKey(name: 'withdraw_minimum')
  final double? withdrawMinimumAmount;
  @JsonKey(name: 'card_enabled', defaultValue: false)
  final bool? cardEnabled;
  @JsonKey(name: 'vodafone_cash_enabled')
  final bool vodafoneCashEnabled;
  @JsonKey(name: 'vodafone_cash_wallet_number')
  final String? vodafoneCashWalletNumber;
  @JsonKey(name: 'vodafone_cash_message')
  final Map<String, String> vodafoneCashMessage;

  @JsonKey(name: 'orange_cash_enabled')
  final bool orangeCashEnabled;
  @JsonKey(name: 'orange_cash_wallet_number')
  final String? orangeCashWalletNumber;
  @JsonKey(name: 'orange_cash_message')
  final Map<String, String> orangeCashMessage;

  @JsonKey(name: 'etisalat_cash_enabled')
  final bool etisalatCashEnabled;
  @JsonKey(name: 'etisalat_cash_wallet_number')
  final String? etisalatCashWalletNumber;
  @JsonKey(name: 'etisalat_cash_message')
  final Map<String, String> etisalatCashMessage;

  @JsonKey(name: 'instapay_enabled')
  final bool instapayEnabled;
  @JsonKey(name: 'instapay_instant_payment_address')
  final String? instapayInstantPaymentAddress;
  @JsonKey(name: 'instapay_message')
  final Map<String, String> instapayMessage;

  @JsonKey(name: 'telda_enabled')
  final bool teldaEnabled;
  @JsonKey(name: 'telda_username')
  final String? teldaUsername;
  @JsonKey(name: 'telda_message')
  final Map<String, String> teldaMessage;

  @JsonKey(name: 'bank_transfer_enabled')
  final bool bankTransferEnabled;
  @JsonKey(name: 'bank_transfer_beneficiary_name')
  final String? bankTransferBeneficiaryName;
  @JsonKey(name: 'bank_transfer_beneficiary_address')
  final String? bankTransferBeneficiaryAddress;
  @JsonKey(name: 'bank_transfer_bank_name')
  final String? bankTransferBankName;
  @JsonKey(name: 'bank_transfer_beneficiary_account_number')
  final String? bankTransferBeneficiaryAccountNumber;
  @JsonKey(name: 'bank_transfer_iban')
  final String? bankTransferIban;
  @JsonKey(name: 'bank_transfer_swift_code')
  final String? bankTransferSwiftCode;
  @JsonKey(name: 'bank_transfer_message')
  final Map<String, String> bankTransferMessage;

  factory PaymentMethodsRM.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodsRMFromJson(json);
}
