import 'online_payment_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class OnlinePaymentLocalizationsAr extends OnlinePaymentLocalizations {
  OnlinePaymentLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appBarTitle => 'الدفع';

  @override
  String get paymentSuccess => 'تمت عملية الدفع بنجاح.';

  @override
  String get paymentFailed => 'فشلت عملية الدفع.';

  @override
  String get generalErrorSnackBarMessage => 'حدث خطأ ما.';
}
