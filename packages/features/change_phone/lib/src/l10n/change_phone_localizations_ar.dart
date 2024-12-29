import 'change_phone_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class ChangePhoneLocalizationsAr extends ChangePhoneLocalizations {
  ChangePhoneLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appBarTitle => 'تغيير رقم الهاتف';

  @override
  String get generalErrorSnackBarMessage => 'حدث خطأ ما';

  @override
  String get incorrectPasswordErrorMessage => 'كلمة المرور غير صحيحة، يرجى المحاولة مرة أخرى';

  @override
  String get requiredFieldErrorMessage => 'مطلوب*';

  @override
  String get phoneTextFieldLabel => 'رقم الهاتف الجديد';

  @override
  String get phoneTextFieldHint => 'أدخل رقم هاتفك الجديد';

  @override
  String get invalidPhoneFormatErrorMessage => 'يرجى إدخال رقم هاتف صحيح';

  @override
  String get phoneIsAlreadyRegisteredErrorMessage => 'الهاتف مسجل بالفعل';

  @override
  String get passwordTextFieldLabel => 'كلمة المرور الحالية';

  @override
  String get changePhoneButtonLabel => 'إرسال';

  @override
  String get changePhoneInProgressButtonLabel => 'جاري تسجيل الدخول';

  @override
  String otpRateLimitExceededErrorSnackBarMessage(Object seconds) {
    return 'لقد وصلت إلى الحد الأقصى لطلبات OTP. يرجى المحاولة مرة أخرى في $seconds ثانية.';
  }

  @override
  String get otpSentSnackBarMessage => 'تم إرسال OTP إلى هاتفك';
}
