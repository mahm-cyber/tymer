import 'wallet_localizations.dart';

/// The translations for English (`en`).
class WalletLocalizationsEn extends WalletLocalizations {
  WalletLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarTitle => 'Wallet';

  @override
  String get withdrawalContainerTitle => 'Withdraw';

  @override
  String get topUpContainerTitle => 'Top Up';
}
