import 'top_up_confirmation_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class TopUpConfirmationLocalizationsAr extends TopUpConfirmationLocalizations {
  TopUpConfirmationLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appBarTitle => 'تأكيد الشحن';

  @override
  String get amountTextFieldLabel => 'المبلغ';

  @override
  String get invalidAmountFormatErrorMessage => 'برجاء إدخال مبلغ صحيح';

  @override
  String get requiredFieldErrorMessage => 'مطلوب*';

  @override
  String get confirmButtonLabel => 'تأكيد';

  @override
  String get confirmingButtonLabel => 'جاري التأكيد...';

  @override
  String get walletNumberTextFieldLabel => 'رقم المحفظة';

  @override
  String get instantPaymentAddressTextFieldLabel => 'عنوان الدفع الفوري';

  @override
  String get isNotEgyptianMobileErrorMessage => 'برجاء إدخال رقم صالح';

  @override
  String get teldaUsernameTextFieldLabel => 'اسم المستخدم';

  @override
  String get isNotGreaterThanZeroTextFieldErrorMessage => 'المبلغ يجب أن يكون أكبر من 0';
}
