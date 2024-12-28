import 'sign_up_localizations.dart';

/// The translations for Arabic (`ar`).
class SignUpLocalizationsAr extends SignUpLocalizations {
  SignUpLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appBarTitle => 'إنشاء حساب جديد';

  @override
  String get signInButtonText => 'تسجيل الدخول';

  @override
  String get emailTextFieldLabel => 'البريد الإلكتروني';

  @override
  String get emailTextFieldHint => 'أدخل بريدك الإلكتروني';

  @override
  String get requiredTextFieldErrorMessage => 'مطلوب';

  @override
  String get invalidCredentialsErrorMessage => 'بيانات الاعتماد غير صالحة، يرجى المحاولة مرة أخرى';

  @override
  String get invalidEmailFormatErrorMessage => 'يرجى إدخال بريد إلكتروني صحيح';

  @override
  String get alreadyRegisteredErrorMessage => 'أنت مسجل بالفعل';

  @override
  String get nameTextFieldHint => 'أدخل اسمك';

  @override
  String get nameTextFieldLabel => 'الاسم الكامل';

  @override
  String get passwordTextFieldLabel => 'كلمة المرور';

  @override
  String get passwordTextFieldHint => 'أدخل كلمة المرور الخاصة بك';

  @override
  String get passwordWeakErrorMessage => 'كلمة المرور الخاصة بك ضعيفة جدًا';

  @override
  String get passwordConfirmationTextFieldLabel => 'تأكيد كلمة المرور';

  @override
  String get passwordConfirmationTextFieldHint => 'أعد إدخال كلمة المرور';

  @override
  String get passwordConfirmationTextFieldError => 'كلمتا المرور غير متطابقتين';

  @override
  String get phoneTextFieldLabel => 'رقم الهاتف';

  @override
  String get phoneTextFieldHint => 'أدخل رقم هاتفك';

  @override
  String get signUpInProgressButtonLabel => 'جارٍ إنشاء الحساب...';

  @override
  String get signUpButtonLabel => 'إنشاء حساب';

  @override
  String get alreadyHaveAnAccount => 'هل لديك حساب بالفعل؟';

  @override
  String get invalidMobileFormatErrorMessage => 'يرجى إدخال رقم هاتف صحيح';

  @override
  String get termsAndConditionsBottomSheetTitle => 'البنود والشروط';

  @override
  String get agreeAndAcceptAllButtonText => 'الموافقة على الشروط والأحكام';

  @override
  String get signUpSuccessMessage => 'تم إرسال رمز التحقق إلى هاتفك';

  @override
  String get signUpFailureMessage => 'فشل إنشاء الحساب، حاول مرة أخرى';

  @override
  String get passwordTextFieldWeakPasswordErrorDescription => 'يجب أن تستوفي كلمة المرور المعايير التالية: - لا يقل طوله عن 6 أحرف - تحتوي على حرف كبير واحد على الأقل - تحتوي على حرف صغير واحد على الأقل - تحتوي على رقم واحد على الأقل - تحتوي على رمز واحد على الأقل (على سبيل المثال، @، \$، !، إلخ.)';
}
