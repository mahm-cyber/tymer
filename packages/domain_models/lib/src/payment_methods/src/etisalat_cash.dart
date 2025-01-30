import 'package:domain_models/domain_models.dart';

class EtisalatCash {
  const EtisalatCash({
    required this.enabled,
    required this.walletNumber,
    required this.message,
    this.type = PaymentMethodType.etisalatCash,
  });

  final bool enabled;
  final String walletNumber;
  final LocalizedMessage message;
  final PaymentMethodType type;
}
