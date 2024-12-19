import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class UserChangeNotifier with ChangeNotifier, EquatableMixin {
  UserChangeNotifier();

  final ValueNotifier<OtpVerification?> _otpVerification = ValueNotifier(null);

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
        _otpVerification,
      ];
}
