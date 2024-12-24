import 'change_phone_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class ChangePhoneLocalizationsEn extends ChangePhoneLocalizations {
  ChangePhoneLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarTitle => 'Change Phone';

  @override
  String get generalErrorSnackBarMessage => 'Something went wrong';

  @override
  String get incorrectPasswordErrorMessage => 'Incorrect password, please try again';

  @override
  String get requiredFieldErrorMessage => 'Required*';

  @override
  String get phoneTextFieldLabel => 'New Phone';

  @override
  String get phoneTextFieldHint => 'Enter your new phone number';

  @override
  String get invalidPhoneFormatErrorMessage => 'Please enter a valid phone number';

  @override
  String get phoneIsAlreadyRegisteredErrorMessage => 'Phone is already registered';

  @override
  String get passwordTextFieldLabel => 'Password';

  @override
  String get changePhoneButtonLabel => 'Submit';

  @override
  String get changePhoneInProgressButtonLabel => 'Signing In';

  @override
  String get otpRateLimitExceededExceptionErrorSnackBarMessage => 'OTP rate limit exceeded, try again later';

  @override
  String get otpSentSnackBarMessage => 'An OTP has been sent to your phone';
}
