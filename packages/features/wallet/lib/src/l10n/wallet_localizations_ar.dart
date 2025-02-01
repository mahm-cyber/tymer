import 'wallet_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class WalletLocalizationsAr extends WalletLocalizations {
  WalletLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appBarTitle => 'المحفظه';

  @override
  String get withdrawalContainerTitle => 'سحب';

  @override
  String get topUpContainerTitle => 'شحن';

  @override
  String get noTransactionsText => 'لا يوجد عمليات';

  @override
  String get earning => 'إيراد';

  @override
  String get payout => 'خروج';
}
