import 'online_payment_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class OnlinePaymentLocalizationsEn extends OnlinePaymentLocalizations {
  OnlinePaymentLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarTitle => 'Payment';

  @override
  String get paymentSuccess => 'Payment completed successfully.';

  @override
  String get paymentFailed => 'Payment failed.';

  @override
  String get generalErrorSnackBarMessage => 'Something went wrong.';
}
