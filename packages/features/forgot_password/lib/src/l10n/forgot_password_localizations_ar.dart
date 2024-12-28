import 'forgot_password_localizations.dart';

/// The translations for Arabic (`ar`).
class ForgotPasswordLocalizationsAr extends ForgotPasswordLocalizations {
  ForgotPasswordLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appBarTitle => 'نسيت كلمة المرور';

  @override
  String get forgotPasswordTitle => 'أدخل رقم الهاتف وسيتم إرسال رمز التحقق OTP حتى تتمكن من إعادة تعيين كلمة المرور.';

  @override
  String get otpSentSuccessfullySnackBarMessage => 'تم إرسال OTP بنجاح.';

  @override
  String get generalErrorSnackBarMessage => 'حدث خطأ ما.';

  @override
  String get requiredFieldErrorMessage => 'مطلوب*';

  @override
  String get invalidEmailFormatErrorMessage => 'تنسيق الهاتف غير صالح';

  @override
  String get phoneNotRegisteredErrorMessage => 'الهاتف غير مسجل';

  @override
  String get forgotPasswordProgressButtonLabel => 'جارٍ إرسال OTP';

  @override
  String get forgotPasswordButtonLabel => 'أرسل الرمز';

  @override
  String get phoneTextFieldLabel => 'رقم الهاتف';

  @override
  String get invalidPhoneFormatErrorMessage => 'يرجى إدخال رقم هاتف صحيح';

  @override
  String get unverifiedPhoneErrorMessage => 'إعادة تعيين كلمة المرور الخاصة بي';

  @override
  String get isNotRegisteredErrorMessage => 'الهاتف غير مسجل';

  @override
  String otpRateLimitExceededErrorSnackBarMessage(Object seconds) {
    return 'لقد وصلت إلى الحد الأقصى لطلبات OTP. يرجى المحاولة مرة أخرى في $seconds ثانية.';
  }
}
