import 'wallet_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class WalletLocalizationsEn extends WalletLocalizations {
  WalletLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarTitle => 'Wallet';

  @override
  String get withdrawalContainerTitle => 'Withdraw';

  @override
  String get topUpContainerTitle => 'Top Up';

  @override
  String get noTransactionsText => 'No transactions found';

  @override
  String get earning => 'Earning';

  @override
  String get payout => 'Payout';
}
