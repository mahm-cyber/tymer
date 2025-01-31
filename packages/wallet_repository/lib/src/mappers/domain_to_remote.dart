//paymentmethodtype rm to dm

import 'package:domain_models/domain_models.dart';

extension PaymentMethodTypeDMtoRM on PaymentMethodType {
  String toRemoteModel() {
    switch (this) {
      case PaymentMethodType.bankCard:
        return 'bank-card';
      case PaymentMethodType.vodafoneCash:
        return 'vodafone-cash';
      case PaymentMethodType.orangeCash:
        return 'orange-cash';
      case PaymentMethodType.etisalatCash:
        return 'etisalat-cash';
      case PaymentMethodType.instaPay:
        return 'instapay';
      case PaymentMethodType.bankTransfer:
        return 'bank-transfer';
    }
  }
}
