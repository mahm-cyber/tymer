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
  String get withdrawConfirmButtonLabel => 'Request Withdraw';

  @override
  String get walletNumberTextFieldLabel => 'Wallet Number';

  @override
  String get ibanNumberTextFieldLabel => 'IBAN Number';

  @override
  String get beneficiaryNameTextFieldLabel => 'Beneficiary Name';

  @override
  String get invalidWalletNumberErrorMessage => 'Please enter a valid wallet number';

  @override
  String get instantPaymentAddressTextFieldLabel => 'Instant Payment Address';

  @override
  String get teldaUsernameTextFieldLabel => 'Telda Username';

  @override
  String get ibanNumberTextFieldError => 'Please enter a valid IBAN number';
}
