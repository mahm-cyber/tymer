import 'sign_in_localizations.dart';

/// The translations for Arabic (`ar`).
class SignInLocalizationsAr extends SignInLocalizations {
  SignInLocalizationsAr([super.locale = 'ar']);

  @override
  String get generalErrorSnackBarMessage => 'حدث خطأ ما';

  @override
  String get invalidCredentialsErrorMessage => 'بريد الكترونى او كلمة مرور خطأ';

  @override
  String get requiredFieldErrorMessage => 'مطلوب*';

  @override
  String get phoneTextFieldLabel => 'البريد الإلكتروني';

  @override
  String get invalidPhoneFormatErrorMessage => 'صيغة البريد الإلكتروني غير صحيح';

  @override
  String get passwordTextFieldLabel => 'كلمة المرور';

  @override
  String get rememberMeCheckBoxLabel => 'تذكرنى';

  @override
  String get forgotMyPasswordButtonLabel => 'فقدت كلمة المرور';

  @override
  String get signInButtonLabel => 'تسجيل دخول';

  @override
  String get signInInProgressButtonLabel => 'جارى تسجيل الدخول';

  @override
  String get unverifiedPhoneErrorMessage => 'البريد الإلكتروني غير مفعل';

  @override
  String get phoneNotVerifiedErrorSnackBarMessage => 'البريد الإلكتروني غير مفعل، تم إرسال رمز التحقق';

  @override
  String get orLoginWith => 'أو تسجيل الدخول بواسطة';

  @override
  String get dontHaveAnAccount => 'ليس لديك حساب؟';

  @override
  String get signUpButtonLabel => 'سجل';

  @override
  String get otpRateLimitExceededExceptionErrorSnackBarMessage => 'تم الوصول إلى الحد الأقصى لطلبات رمز التحقق';
}
