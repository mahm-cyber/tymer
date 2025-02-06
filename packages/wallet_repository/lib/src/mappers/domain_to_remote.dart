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
      case PaymentMethodType.telda:
        return 'telda';
    }
  }
}

extension PaymentTypeDMtoRM on TransactionType {
  String toRemoteModel() {
    switch (this) {
      case TransactionType.withdraw:
        return 'withdraw';
      case TransactionType.payout:
        return 'payout';
      case TransactionType.earning:
        return 'earning';
      case TransactionType.topup:
        return 'top-up';
      case TransactionType.refund:
        return 'refund';
      case TransactionType.bonus:
        return 'bonus';
      case TransactionType.chargeback:
        return 'chargeback';
    }
  }
}
