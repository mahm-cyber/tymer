import 'forgot_password_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class ForgotPasswordLocalizationsEn extends ForgotPasswordLocalizations {
  ForgotPasswordLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarTitle => 'Forgot Password';

  @override
  String get forgotPasswordTitle => 'Enter your phone number, and an OTP will be sent to reset your password.';

  @override
  String get otpSentSuccessfullySnackBarMessage => 'OTP sent successfully.';

  @override
  String get generalErrorSnackBarMessage => 'ٍSomething went wrong.';

  @override
  String get requiredFieldErrorMessage => 'Required*';

  @override
  String get invalidEmailFormatErrorMessage => 'Invalid phone format';

  @override
  String get phoneNotRegisteredErrorMessage => 'Phone not registered';

  @override
  String get forgotPasswordProgressButtonLabel => 'Sending OTP';

  @override
  String get forgotPasswordButtonLabel => 'Send Code';

  @override
  String get phoneTextFieldLabel => 'Phone Number';

  @override
  String get invalidPhoneFormatErrorMessage => 'Please enter a valid phone number';

  @override
  String get unverifiedPhoneErrorMessage => 'Reset My Password';

  @override
  String get isNotRegisteredErrorMessage => 'Phone not registered';

  @override
  String otpRateLimitExceededErrorSnackBarMessage(Object seconds) {
    return 'Maximum number of OTP requests reached. Please try again in $seconds seconds.';
  }
}
