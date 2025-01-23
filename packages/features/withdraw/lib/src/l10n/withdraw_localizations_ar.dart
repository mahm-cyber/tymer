import 'withdraw_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class WithdrawLocalizationsAr extends WithdrawLocalizations {
  WithdrawLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appBarTitle => 'السحب';

  @override
  String get withdrawAmountTextFieldLabel => 'مبلغ السحب';

  @override
  String get withdrawAmountTextFieldHint => 'أدخل مبلغ السحب';

  @override
  String get isNotNumberTextFieldErrorMessage => 'الرجاء إدخال رقم صحيح';

  @override
  String get withdrawConfirmButtonLabel => 'سحب';
}
