import 'package:domain_models/domain_models.dart';

class VodafoneCash {
  const VodafoneCash({
    required this.enabled,
     this.walletNumber,
    required this.message,
    this.type = PaymentMethodType.vodafoneCash,
  });

  final bool enabled;
  final String? walletNumber;
  final LocalizedMessage message;
  final PaymentMethodType type;
}
