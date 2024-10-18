import 'forgot_password_localizations.dart';

/// The translations for Arabic (`ar`).
class ForgotPasswordLocalizationsAr extends ForgotPasswordLocalizations {
  ForgotPasswordLocalizationsAr([super.locale = 'ar']);

  @override
  String get appBarTitle => 'نسيت كلمة المرور';

  @override
  String get otpSentSuccessfullySnackBarMessage => 'حدث خطأ ما';

  @override
  String get generalErrorSnackBarMessage => 'حدث خطأ ما';

  @override
  String get requiredFieldErrorMessage => 'مطلوب*';

  @override
  String get invalidEmailFormatErrorMessage => 'تنسيق الهاتف غير صالح';

  @override
  String get phoneNotRegisteredErrorMessage => 'الهاتف غير مسجل';

  @override
  String get forgotPasswordProgressButtonLabel => 'جارٍ إرسال OTP';

  @override
  String get forgotPasswordButtonLabel => 'إعادة تعيين كلمة المرور الخاصة بي';

  @override
  String get phoneTextFieldLabel => 'الهاتف';

  @override
  String get invalidPhoneFormatErrorMessage => 'تنسيق الهاتف غير صالح';

  @override
  String get unverifiedPhoneErrorMessage => 'إعادة تعيين كلمة المرور الخاصة بي';

  @override
  String get isNotRegisteredErrorMessage => 'الهاتف غير مسجل';
}
