class OtpVerification {
  const OtpVerification({
    required this.phone,
    required this.reason,
  });

  final String phone;
  final OtpVerificationReason reason;


  bool get isForgotPassword => reason == OtpVerificationReason.forgotPassword;
  bool get isLoggingIn => reason == OtpVerificationReason.login;
  bool get isRegistering => reason == OtpVerificationReason.register;
}

enum OtpVerificationReason {
  register,
  login,
  forgotPassword,
}
