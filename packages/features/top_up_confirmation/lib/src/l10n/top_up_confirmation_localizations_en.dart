import 'top_up_confirmation_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class TopUpConfirmationLocalizationsEn extends TopUpConfirmationLocalizations {
  TopUpConfirmationLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarTitle => 'Top Up Confirmation';

  @override
  String get amountTextFieldLabel => 'Amount';

  @override
  String get invalidAmountFormatErrorMessage => 'Please enter a valid amount';

  @override
  String get requiredFieldErrorMessage => 'Required*';

  @override
  String get confirmButtonLabel => 'Confirm';

  @override
  String get confirmingButtonLabel => 'Confirming...';

  @override
  String get walletNumberTextFieldLabel => 'Wallet Number';

  @override
  String get instantPaymentAddressTextFieldLabel => 'Instant Payment Address';

  @override
  String get isNotEgyptianMobileErrorMessage => 'Please enter a valid number';

  @override
  String get teldaUsernameTextFieldLabel => 'Telda Username';
}
