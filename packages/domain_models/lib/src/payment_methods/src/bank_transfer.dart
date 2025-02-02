import 'package:domain_models/domain_models.dart';

class BankTransfer {
  const BankTransfer({
    required this.enabled,
    this.beneficiaryName,
    this.beneficiaryAddress,
    this.bankName,
    this.beneficiaryAccountNumber,
    this.iban,
    this.swiftCode,
    required this.message,
    this.type = PaymentMethodType.bankTransfer,
  });

  final bool enabled;
  final String? beneficiaryName;
  final String? beneficiaryAddress;
  final String? bankName;
  final String? beneficiaryAccountNumber;
  final String? iban;
  final String? swiftCode;
  final LocalizedMessage message;
  final PaymentMethodType type;
}
