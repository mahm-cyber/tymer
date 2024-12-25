import 'sign_in_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SignInLocalizationsEn extends SignInLocalizations {
  SignInLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarTitle => 'Sign In';

  @override
  String get generalErrorSnackBarMessage => 'ٍSomething went wrong.';

  @override
  String get invalidCredentialsErrorMessage => 'Incorrect phone or password';

  @override
  String get requiredFieldErrorMessage => 'Required*';

  @override
  String get phoneTextFieldLabel => 'Phone';

  @override
  String get invalidPhoneFormatErrorMessage => 'Please enter a valid phone number';

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

  @override
  String get unverifiedPhoneErrorMessage => 'Phone is not verified';

  @override
  String get phoneNotVerifiedErrorSnackBarMessage => 'Phone unverified, an OTP has been sent.';

  @override
  String get orLoginWith => 'Or login with';

  @override
  String get dontHaveAnAccount => 'Don\'t have an account?';

  @override
  String get signUpButtonLabel => 'Sign Up';

  @override
  String otpRateLimitExceededErrorSnackBarMessage(Object seconds) {
    return 'Maximum number of OTP requests reached. Please try again in $seconds seconds.';
  }
}
