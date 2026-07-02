import 'dart:async';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class WalletChangeNotifier with ChangeNotifier {
  WalletChangeNotifier();

  final _refreshTransactionsController = StreamController<void>.broadcast();
  Stream<void> get refreshTransactionsStream => _refreshTransactionsController.stream;

  void triggerRefreshTransactions() {
    _refreshTransactionsController.add(null);
  }

  // Payment Methods

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

  // Withdraw Methods
  final ValueNotifier<PaymentMethods?> _withdrawMethodsVN = ValueNotifier(null);
  PaymentMethods? get withdrawMethods => _withdrawMethodsVN.value;
  void setWithdrawMethods(PaymentMethods withdrawMethods) {
    _withdrawMethodsVN.value = withdrawMethods;
    notifyListeners();
  }

  Future clearWithdrawMethods() async {
    _withdrawMethodsVN.value = null;
    notifyListeners();
  }

  // Payment Type
  final ValueNotifier<TransactionType?> _paymentTypeVN = ValueNotifier(null);
  TransactionType? get paymentType => _paymentTypeVN.value;
  void setPaymentType(TransactionType paymentType) {
    _paymentTypeVN.value = paymentType;
    notifyListeners();
  }

  void clearPaymentType() {
    _paymentTypeVN.value = null;
    notifyListeners();
  }

  // Clear All
  void clearAll() {
    _paymentMethodsVN.value = null;
    _withdrawMethodsVN.value = null;
    _paymentTypeVN.value = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _refreshTransactionsController.close();
    super.dispose();
  }
}

