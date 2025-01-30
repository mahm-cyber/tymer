import 'package:domain_models/domain_models.dart';

class BankTransfer {
  const BankTransfer({
    required this.enabled,
    required this.beneficiaryName,
    required this.beneficiaryAddress,
    required this.bankName,
    required this.beneficiaryAccountNumber,
    required this.iban,
    required this.swiftCode,
    required this.message,
    this.type = PaymentMethodType.bankTransfer,
  });

  final bool enabled;
  final String beneficiaryName;
  final String beneficiaryAddress;
  final String bankName;
  final String beneficiaryAccountNumber;
  final String iban;
  final String swiftCode;
  final LocalizedMessage message;
  final PaymentMethodType type;
}
