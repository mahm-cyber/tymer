import 'top_up_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class TopUpLocalizationsAr extends TopUpLocalizations {
  TopUpLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appBarTitle => 'الشحن';

  @override
  String get topUpAmountTextFieldLabel => 'مبلغ الشحن';

  @override
  String get topUpAmountTextFieldHint => 'أدخل مبلغ الشحن';

  @override
  String get isNotNumberTextFieldErrorMessage => 'الرجاء إدخال رقم صحيح';

  @override
  String get topUpConfirmButtonLabel => 'شحن';
}
