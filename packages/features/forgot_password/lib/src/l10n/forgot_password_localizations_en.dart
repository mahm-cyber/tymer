import 'forgot_password_localizations.dart';

/// The translations for English (`en`).
class ForgotPasswordLocalizationsEn extends ForgotPasswordLocalizations {
  ForgotPasswordLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarTitle => 'Forgot Password';

  @override
  String get otpSentSuccessfullySnackBarMessage => 'OTP sent successfully';

  @override
  String get generalErrorSnackBarMessage => 'ٍSomething went wrong';

  @override
  String get requiredFieldErrorMessage => 'Required*';

  @override
  String get invalidEmailFormatErrorMessage => 'Invalid phone format';

  @override
  String get phoneNotRegisteredErrorMessage => 'Phone not registered';

  @override
  String get forgotPasswordProgressButtonLabel => 'Sending OTP';

  @override
  String get forgotPasswordButtonLabel => 'Reset My Password';

  @override
  String get phoneTextFieldLabel => 'Phone';

  @override
  String get invalidPhoneFormatErrorMessage => 'Invalid phone format';

  @override
  String get unverifiedPhoneErrorMessage => 'Reset My Password';

  @override
  String get isNotRegisteredErrorMessage => 'Phone not registered';

  @override
  String otpRateLimitExceededErrorSnackBarMessage(Object seconds) {
    return 'You have reached the maximum number of OTP requests. Please try again in $seconds';
  }
}
