import 'top_up_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class TopUpLocalizationsEn extends TopUpLocalizations {
  TopUpLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarTitle => 'Top Up';

  @override
  String get topUpAmountTextFieldLabel => 'Top Up Amount';

  @override
  String get topUpAmountTextFieldHint => 'Enter Top Up Amount';

  @override
  String get isNotNumberTextFieldErrorMessage => 'Please enter a valid number';

  @override
  String get topUpConfirmButtonLabel => 'Top Up';
}
