import 'payment_history_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class PaymentHistoryLocalizationsAr extends PaymentHistoryLocalizations {
  PaymentHistoryLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get noTopupPaymentsText => 'لا يوجد طلبات شحن متاحة';

  @override
  String get noWithdrawalPaymentsText => 'لا يوجد طلبات سحب متاحة';

  @override
  String get topupHistoryAppBarTitle => 'طلبات الشحن';

  @override
  String get withdrawHistoryAppBarTitle => 'طلبات السحب';

  @override
  String get ibanNumberLabel => 'رقم الحساب البنكي';

  @override
  String get beneficiaryNameLabel => 'المستفيد';

  @override
  String get walletNumberLabel => 'المحفظة';

  @override
  String get instantPaymentAddressLabel => 'انستاباي';

  @override
  String get amountLabel => 'المبلغ';

  @override
  String get statusLabel => 'الحالة';

  @override
  String get dateLabel => 'التاريخ';
}
