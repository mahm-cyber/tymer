import 'sign_in_localizations.dart';

/// The translations for Arabic (`ar`).
class SignInLocalizationsAr extends SignInLocalizations {
  SignInLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get generalErrorSnackBarMessage => 'ٍSomething went wrong';

  @override
  String get invalidCredentialsErrorMessage => 'بريد الكترونى او كلمة مرور خطأ';

  @override
  String get requiredFieldErrorMessage => 'مطلوب*';

  @override
  String get emailTextFieldLabel => 'البريد الإلكتروني';

  @override
  String get invalidEmailFormatErrorMessage => 'صيغة البريد الإلكتروني غير صحيح';

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
}
