import 'withdraw_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class WithdrawLocalizationsEn extends WithdrawLocalizations {
  WithdrawLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarTitle => 'Withdraw';

  @override
  String get withdrawAmountTextFieldLabel => 'Withdraw Amount';

  @override
  String get withdrawAmountTextFieldHint => 'Enter Withdraw Amount';

  @override
  String get isNotNumberTextFieldErrorMessage => 'Please enter a valid number';

  @override
  String get withdrawConfirmButtonLabel => 'Withdraw';
}
