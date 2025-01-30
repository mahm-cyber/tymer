import 'package:domain_models/domain_models.dart';

class PaymentMethods {
  const PaymentMethods({
    required this.vodafoneCash,
    required this.orangeCash,
    required this.etisalatCash,
    required this.instaPay,
    required this.bankTransfer,
    this.pickedPaymentMethodType,
  });

  final VodafoneCash vodafoneCash;
  final OrangeCash orangeCash;
  final EtisalatCash etisalatCash;
  final InstaPay instaPay;
  final BankTransfer bankTransfer;
  final PaymentMethodType? pickedPaymentMethodType;

  PaymentMethods copyWith({
    PaymentMethodType? pickedPaymentMethodType,
  }) =>
      PaymentMethods(
        vodafoneCash: vodafoneCash,
        orangeCash: orangeCash,
        etisalatCash: etisalatCash,
        instaPay: instaPay,
        bankTransfer: bankTransfer,
        pickedPaymentMethodType:
            pickedPaymentMethodType ?? this.pickedPaymentMethodType,
      );
}
