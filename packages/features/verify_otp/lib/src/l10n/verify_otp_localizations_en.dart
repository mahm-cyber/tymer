import 'verify_otp_localizations.dart';

/// The translations for English (`en`).
class VerifyOtpLocalizationsEn extends VerifyOtpLocalizations {
  VerifyOtpLocalizationsEn([super.locale = 'en']);

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
  String get otpLimitCrossedErrorSnackBarMessage => 'Limit of OTP verification attempts crossed';
}
