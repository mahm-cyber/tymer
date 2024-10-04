class OtpVerification {
  const OtpVerification({
    required this.phone,
    required this.reason,
  });

  final String phone;
  final OtpVerificationReason reason;

  bool get isRegistrationOrLogin =>
      reason == OtpVerificationReason.register ||
      reason == OtpVerificationReason.login;
  bool get isResetPassword => reason == OtpVerificationReason.resetPassword;
  bool get isLoggingIn => reason == OtpVerificationReason.login;
  bool get isRegistering => reason == OtpVerificationReason.register;
}

enum OtpVerificationReason {
  register,
  login,
  resetPassword,
}
