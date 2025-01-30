import 'package:domain_models/domain_models.dart';

class OrangeCash {
  const OrangeCash({
    required this.enabled,
    required this.walletNumber,
    required this.message,
    this.type = PaymentMethodType.orangeCash,
  });

  final bool enabled;
  final String walletNumber;
  final LocalizedMessage message;
  final PaymentMethodType type;
}
