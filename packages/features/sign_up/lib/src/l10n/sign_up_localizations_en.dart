import 'sign_up_localizations.dart';

/// The translations for English (`en`).
class SignUpLocalizationsEn extends SignUpLocalizations {
  SignUpLocalizationsEn([super.locale = 'en']);

  @override
  String get appBarTitle => 'Sign Up';

  @override
  String get signInButtonText => 'Sign In';

  @override
  String get emailTextFieldLabel => 'Email Address';

  @override
  String get emailTextFieldHint => 'Enter your email';

  @override
  String get requiredTextFieldErrorMessage => 'This field is required.';

  @override
  String get invalidCredentialsErrorMessage => 'Invalid credentials, please try again.';

  @override
  String get invalidFormatErrorMessage => 'Invalid format, please check your input.';

  @override
  String get alreadyRegisteredErrorMessage => 'You are already registered.';

  @override
  String get nameTextFieldHint => 'Enter your name';

  @override
  String get nameTextFieldLabel => 'Full Name';

  @override
  String get passwordTextFieldLabel => 'Password';

  @override
  String get passwordTextFieldHint => 'Enter your password';

  @override
  String get passwordWeakErrorMessage => 'Your password is too weak.';

  @override
  String get passwordConfirmationTextFieldLabel => 'Confirm Password';

  @override
  String get passwordConfirmationTextFieldHint => 'Re-enter your password';

  @override
  String get passwordConfirmationTextFieldError => 'Passwords do not match.';

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
  String get invalidMobileFormatErrorMessage => 'Invalid mobile number format';

  @override
  String get termsAndConditionsBottomSheetTitle => 'Terms and Conditions';

  @override
  String get agreeAndAcceptAllButtonText => 'Agree and Accept All';

  @override
  String get signUpSuccessMessage => 'An OTP has been sent to your phone';

  @override
  String get signUpFailureMessage => 'Sign Up Failed, try again';
}
