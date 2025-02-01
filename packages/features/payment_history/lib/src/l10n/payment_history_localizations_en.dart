import 'payment_history_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class PaymentHistoryLocalizationsEn extends PaymentHistoryLocalizations {
  PaymentHistoryLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get noTopupPaymentsText => 'No topups available';

  @override
  String get noWithdrawalPaymentsText => 'No withdrawals available';

  @override
  String get topupHistoryAppBarTitle => 'Topup History';

  @override
  String get withdrawHistoryAppBarTitle => 'Withdrawal History';

  @override
  String get ibanNumberLabel => 'IBAN';

  @override
  String get beneficiaryNameLabel => 'Beneficiary';

  @override
  String get walletNumberLabel => 'Wallet';

  @override
  String get instantPaymentAddressLabel => 'InstaPay';

  @override
  String get amountLabel => 'Amount';

  @override
  String get statusLabel => 'Status';

  @override
  String get dateLabel => 'Date';
}
