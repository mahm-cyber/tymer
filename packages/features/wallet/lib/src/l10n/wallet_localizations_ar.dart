import 'wallet_localizations.dart';

/// The translations for Arabic (`ar`).
class WalletLocalizationsAr extends WalletLocalizations {
  WalletLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appBarTitle => 'المحفظه';

  @override
  String get withdrawalContainerTitle => 'سحب';

  @override
  String get topUpContainerTitle => 'شحن';
}
