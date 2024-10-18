import 'reset_password_localizations.dart';

/// The translations for English (`en`).
class ResetPasswordLocalizationsEn extends ResetPasswordLocalizations {
  ResetPasswordLocalizationsEn([super.locale = 'en']);

  @override
  String get resetPasswordSuccessMessage => 'Your password has been reset successfully';

  @override
  String get resetPasswordScreenTitle => 'Reset Password';

  @override
  String get resetPasswordScreenSubtitle => 'Reset Password';

  @override
  String get submissionInProgressButtonLabel => 'Submitting';

  @override
  String get submitButtonLabel => 'Submit';

  @override
  String get newPasswordTextFieldLabel => 'New Password';

  @override
  String get requiredFieldErrorMessage => 'This field is required';

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
}
