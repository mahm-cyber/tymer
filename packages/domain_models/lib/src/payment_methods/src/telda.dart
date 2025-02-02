import 'package:domain_models/domain_models.dart';

class Telda {
  const Telda({
    required this.enabled,
    this.username,
    required this.message,
    this.type = PaymentMethodType.telda,
  });

  final bool enabled;
  final String? username;
  final LocalizedMessage message;
  final PaymentMethodType type;
}
