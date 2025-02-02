import 'package:domain_models/domain_models.dart';

class InstaPay {
  const InstaPay({
    required this.enabled,
    this.instantPaymentAddress,
    required this.message,
    this.type = PaymentMethodType.instaPay,
  });

  final bool enabled;
  final String? instantPaymentAddress;
  final LocalizedMessage message;
  final PaymentMethodType type;
}
