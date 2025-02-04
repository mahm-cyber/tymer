import 'package:domain_models/domain_models.dart';

class PaymentMethods {
  const PaymentMethods({
    this.minimumAmount,
    required this.vodafoneCash,
    required this.orangeCash,
    required this.etisalatCash,
    required this.instaPay,
    required this.bankTransfer,
    required this.telda,
    this.pickedPaymentMethodType,
  });

  final double? minimumAmount;
  final VodafoneCash vodafoneCash;
  final OrangeCash orangeCash;
  final EtisalatCash etisalatCash;
  final InstaPay instaPay;
  final BankTransfer bankTransfer;
  final Telda telda;
  final PaymentMethodType? pickedPaymentMethodType;

  PaymentMethods copyWith({
    PaymentMethodType? pickedPaymentMethodType,
  }) =>
      PaymentMethods(
        minimumAmount: minimumAmount,
        vodafoneCash: vodafoneCash,
        orangeCash: orangeCash,
        etisalatCash: etisalatCash,
        instaPay: instaPay,
        bankTransfer: bankTransfer,
        telda: telda,
        pickedPaymentMethodType:
            pickedPaymentMethodType ?? this.pickedPaymentMethodType,
      );
}
