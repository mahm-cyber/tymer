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
  String get withdrawConfirmButtonLabel => 'طلب السحب';

  @override
  String get walletNumberTextFieldLabel => 'رقم المحفظة';

  @override
  String get ibanNumberTextFieldLabel => 'رقم الحساب البنكي';

  @override
  String get beneficiaryNameTextFieldLabel => 'اسم المستفيد';

  @override
  String get invalidWalletNumberErrorMessage => 'الرجاء إدخال رقم محفظة صحيح';

  @override
  String get instantPaymentAddressTextFieldLabel => 'عنوان الدفع الفوري';

  @override
  String get teldaUsernameTextFieldLabel => 'اسم مستخدم تلدا';
}
