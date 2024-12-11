import 'verify_otp_localizations.dart';

/// The translations for English (`en`).
class VerifyOtpLocalizationsEn extends VerifyOtpLocalizations {
  VerifyOtpLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get verifyOtpTitle => 'Verify OTP';

  @override
  String get otpResentSuccessfullySnackBarMessage => 'OTP resent successfully';

  @override
  String get otpResentErrorSnackBarMessage => 'Error occurred while resending OTP';

  @override
  String get otpVerifiedSuccessfullySnackBarMessage => 'OTP verified successfully';

  @override
  String get generalErrorSnackBarMessage => 'An error occurred';

  @override
  String get verifyOtpSubtitle => 'Enter the OTP sent to your phone number to change your password';

  @override
  String get requiredFieldErrorMessage => 'Required*';

  @override
  String get incorrectOtpCodeErrorMessage => 'The OTP you entered is incorrect, please try again';

  @override
  String get verifyingOtpButtonLabel => 'Verifying';

  @override
  String get verifyOtpButtonLabel => 'Verify OTP';

  @override
  String get emailNotRegisteredErrorMessage => 'The email you entered is not registered';

  @override
  String get resendOtpButtonLabel => 'Resend OTP';

  @override
  String get changeEmailSubtitle => 'Enter the OTP sent to your phone number to change your email';

  @override
  String otpLimitExceededErrorSnackBarMessage(Object seconds) {
    return 'You have reached the maximum number of OTP requests. Please try again in $seconds seconds';
  }

  @override
  String get newPasswordTextFieldLabel => 'New Password';

  @override
  String get newPasswordTextFieldWeakPasswordError => 'The password is too weak';

  @override
  String get newPasswordTextFieldHint => 'Enter your new password';

  @override
  String get newPasswordConfirmationTextFieldLabel => 'Confirm New Password';

  @override
  String get newPasswordConfirmationTextFieldHint => 'Re-enter your new password';

  @override
  String get passwordConfirmationTextFieldDoesNotMatchError => 'Passwords do not match';

  @override
  String get passwordTextFieldWeakPasswordErrorDescription => 'The password must have At least 6 characters long, Contains at least one uppercase letter, Contains at least one lowercase letter, Contains at least one number, Contains at least one symbol (e.g., @, \$, !, etc.)';

  @override
  String get passwordResetSuccessfullySnackBarMessage => 'Password reset successfully';
}
