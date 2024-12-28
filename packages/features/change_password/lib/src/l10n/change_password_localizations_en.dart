import 'change_password_localizations.dart';

/// The translations for English (`en`).
class ChangePasswordLocalizationsEn extends ChangePasswordLocalizations {
  ChangePasswordLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarTitle => 'Change Password';

  @override
  String get requiredTextFieldErrorMessage => 'Required*';

  @override
  String get incorrectPasswordErrorMessage => 'Incorrect password, please try again';

  @override
  String get passwordTextFieldLabel => 'Current Password';

  @override
  String get passwordTextFieldHint => 'Enter your current password';

  @override
  String get newPasswordTextFieldLabel => 'New Password';

  @override
  String get newPasswordTextFieldHint => 'Enter your new password';

  @override
  String get newPasswordWeakErrorMessage => 'Your new password is too weak';

  @override
  String get newPasswordConfirmationTextFieldLabel => 'Confirm new password';

  @override
  String get newPasswordConfirmationTextFieldHint => 'Re-enter your new password';

  @override
  String get newPasswordConfirmationTextFieldError => 'Passwords do not match';

  @override
  String get changePasswordInProgressButtonLabel => 'Signing Up...';

  @override
  String get changePasswordButtonLabel => 'Change Password';

  @override
  String get changePasswordSuccessMessage => 'Password changed successfully';

  @override
  String get changePasswordFailureMessage => 'Change password failed, try again';

  @override
  String get newPasswordTextFieldWeakPasswordErrorDescription => 'The password must have At least 8 characters long, Contains at least one uppercase letter, Contains at least one lowercase letter, Contains at least one number, Contains at least one symbol (e.g., @, ';
}
