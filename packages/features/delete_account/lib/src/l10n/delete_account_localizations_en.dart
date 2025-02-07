import 'delete_account_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class DeleteAccountLocalizationsEn extends DeleteAccountLocalizations {
  DeleteAccountLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get deleteAccountTitle => 'Delete Account';

  @override
  String get deleteAccountContent => 'Are you sure you want to delete your account?';

  @override
  String get deleteAccountButton => 'Delete';

  @override
  String get cancelButtonLabel => 'Cancel';

  @override
  String get deleteAccountSuccessMessage => 'Account deleted successfully';

  @override
  String get passwordTextFieldLabel => 'Password';

  @override
  String get requiredFieldErrorMessage => 'Required*';

  @override
  String get invalidCredentialsErrorMessage => 'Wrong password';
}
