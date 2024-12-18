import 'sign_up_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SignUpLocalizationsEn extends SignUpLocalizations {
  SignUpLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarTitle => 'Create New Account';

  @override
  String get signInButtonText => 'Sign In';

  @override
  String get emailTextFieldLabel => 'Email Address';

  @override
  String get emailTextFieldHint => 'Enter your email';

  @override
  String get requiredTextFieldErrorMessage => 'Required*';

  @override
  String get invalidCredentialsErrorMessage => 'Invalid credentials, please try again';

  @override
  String get invalidEmailFormatErrorMessage => 'Please enter a valid email address';

  @override
  String get alreadyRegisteredErrorMessage => 'You are already registered';

  @override
  String get nameTextFieldHint => 'Enter your name';

  @override
  String get nameTextFieldLabel => 'Full Name';

  @override
  String get passwordTextFieldLabel => 'Password';

  @override
  String get passwordTextFieldHint => 'Enter your password';

  @override
  String get passwordWeakErrorMessage => 'Your password is too weak';

  @override
  String get passwordConfirmationTextFieldLabel => 'Confirm Password';

  @override
  String get passwordConfirmationTextFieldHint => 'Re-enter your password';

  @override
  String get passwordConfirmationTextFieldError => 'Passwords do not match';

  @override
  String get phoneTextFieldLabel => 'Phone Number';

  @override
  String get phoneTextFieldHint => 'Enter your phone number';

  @override
  String get signUpInProgressButtonLabel => 'Signing Up...';

  @override
  String get signUpButtonLabel => 'Sign Up';

  @override
  String get alreadyHaveAnAccount => 'Already have an account?';

  @override
  String get invalidMobileFormatErrorMessage => 'Please enter a valid phone number';

  @override
  String get termsAndConditionsBottomSheetTitle => 'Terms and Conditions';

  @override
  String get agreeAndAcceptAllButtonText => 'Agree to Terms and Conditions';

  @override
  String get signUpSuccessMessage => 'An OTP has been sent to your phone';

  @override
  String get signUpFailureMessage => 'Sign Up Failed, try again';

  @override
  String get passwordTextFieldWeakPasswordErrorDescription => 'The password must have At least 6 characters long, Contains at least one uppercase letter, Contains at least one lowercase letter, Contains at least one number, Contains at least one symbol (e.g., @, ';
}
