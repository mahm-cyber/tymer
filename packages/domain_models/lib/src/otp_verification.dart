class OtpVerification {
  const OtpVerification({
    required this.phone,
    required this.reason,
    this.password
  });

  final String phone;
  final OtpVerificationReason reason;
  final String? password;

  bool get isForgotPassword => reason == OtpVerificationReason.forgotPassword;
  bool get isLoggingIn => reason == OtpVerificationReason.login;
  bool get isRegistering => reason == OtpVerificationReason.register;
}

enum OtpVerificationReason {
  register,
  login,
  forgotPassword,
  changePhone,
}
