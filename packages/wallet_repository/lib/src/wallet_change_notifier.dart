import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class WalletChangeNotifier with ChangeNotifier {
  WalletChangeNotifier();

  final ValueNotifier<PaymentMethods?> _paymentMethodsVN = ValueNotifier(null);


  PaymentMethods? get paymentMethods => _paymentMethodsVN.value;
  void setPaymentMethods(PaymentMethods paymentMethods) {
    _paymentMethodsVN.value = paymentMethods;
    notifyListeners();
  }
  Future clearPaymentMethods() async {
    _paymentMethodsVN.value = null;
    notifyListeners();
  }
} 