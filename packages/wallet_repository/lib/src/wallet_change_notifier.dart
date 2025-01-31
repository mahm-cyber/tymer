import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class WalletChangeNotifier with ChangeNotifier {
  WalletChangeNotifier();

  final ValueNotifier<PaymentMethods?> _paymentMethodsVN = ValueNotifier(null);
  final ValueNotifier<PaymentMethods?> _withdrawMethodsVN = ValueNotifier(null);

  PaymentMethods? get paymentMethods => _paymentMethodsVN.value;
  PaymentMethods? get withdrawMethods => _withdrawMethodsVN.value;

  void setPaymentMethods(PaymentMethods paymentMethods) {
    _paymentMethodsVN.value = paymentMethods;
    notifyListeners();
  }

  void setWithdrawMethods(PaymentMethods withdrawMethods) {
    _withdrawMethodsVN.value = withdrawMethods;
    notifyListeners();
  }

  Future clearPaymentMethods() async {
    _paymentMethodsVN.value = null;
    notifyListeners();
  }

  Future clearWithdrawMethods() async {
    _withdrawMethodsVN.value = null;
    notifyListeners();
  }
}
