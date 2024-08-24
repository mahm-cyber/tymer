import 'send_otp_localizations.dart';

/// The translations for English (`en`).
class SendOtpLocalizationsEn extends SendOtpLocalizations {
  SendOtpLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get generalErrorSnackBarMessage => 'ٍSomething went wrong';

  @override
  String get invalidCredentialsErrorMessage => 'Incorrect email or password';

  @override
  String get requiredFieldErrorMessage => 'Required*';

  @override
  String get emailTextFieldLabel => 'Email';

  @override
  String get invalidEmailFormatErrorMessage => 'Invalid email format';

  @override
  String get passwordTextFieldLabel => 'Password';

  @override
  String get rememberMeCheckBoxLabel => 'Remember Me';

  @override
  String get forgotMyPasswordButtonLabel => 'Forgot Password';

  @override
  String get signInButtonLabel => 'Sign In';

  @override
  String get signInInProgressButtonLabel => 'Signing In';
}
