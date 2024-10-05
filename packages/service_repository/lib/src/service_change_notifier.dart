import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class UserChangeNotifier with ChangeNotifier, EquatableMixin {
  UserChangeNotifier();

  final ValueNotifier<dynamic> _drawerAssociator = ValueNotifier(null);
  final ValueNotifier<OtpVerification?> _otpVerification = ValueNotifier(null);

  /// This is used to carry either Task, Contact, Deal, or Company
  /// to the [AssociateWithDrawer]
  dynamic get drawerAssociator => _drawerAssociator.value;
  void setDrawerAssociator(dynamic associator) {
    _drawerAssociator.value = associator;
    notifyListeners();
  }
  Future clearDrawerAssociator() async {
    _drawerAssociator.value = null;
    notifyListeners();
  }

  // This is a notifier of the otp verification
  OtpVerification? get otpVerification => _otpVerification.value;
  void setOtpVerification(OtpVerification? otpVerification) {
    _otpVerification.value = otpVerification;
    notifyListeners();
  }
  Future clearOtpVerification() async {
    _otpVerification.value = null;
    notifyListeners();
  }

  @override
  List<Object?> get props => [
        _drawerAssociator,
        _otpVerification,
      ];
}
