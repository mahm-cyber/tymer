import 'sign_in_localizations.dart';

/// The translations for Arabic (`ar`).
class SignInLocalizationsAr extends SignInLocalizations {
  SignInLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appBarTitle => 'تسجيل الدخول';

  @override
  String get generalErrorSnackBarMessage => 'حدث خطأ ما.';

  @override
  String get invalidCredentialsErrorMessage => 'الهاتف او كلمة مرور خطأ';

  @override
  String get requiredFieldErrorMessage => 'مطلوب*';

  @override
  String get phoneTextFieldLabel => 'الهاتف';

  @override
  String get invalidPhoneFormatErrorMessage => 'يرجى إدخال رقم هاتف صحيح';

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
  String get unverifiedPhoneErrorMessage => 'الهاتف غير مفعل';

  @override
  String get phoneNotVerifiedErrorSnackBarMessage => 'الهاتف غير مفعل، تم إرسال رمز التحقق.';

  @override
  String get orLoginWith => 'أو تسجيل الدخول بواسطة';

  @override
  String get dontHaveAnAccount => 'ليس لديك حساب؟';

  @override
  String get signUpButtonLabel => 'سجل';

  @override
  String get otpRateLimitExceededExceptionErrorSnackBarMessage => 'تجاوز حد الرسائل القصيرة، حاول لاحقا.';
}
