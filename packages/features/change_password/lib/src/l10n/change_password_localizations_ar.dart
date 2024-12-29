import 'change_password_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class ChangePasswordLocalizationsAr extends ChangePasswordLocalizations {
  ChangePasswordLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appBarTitle => 'تغيير كلمة المرور';

  @override
  String get requiredTextFieldErrorMessage => 'مطلوب*';

  @override
  String get incorrectPasswordErrorMessage => 'كلمة المرور غير صحيحة، يرجى المحاولة مرة أخرى';

  @override
  String get passwordTextFieldLabel => 'كلمة المرور الحالية';

  @override
  String get passwordTextFieldHint => 'أدخل كلمة المرور الحالية';

  @override
  String get newPasswordTextFieldLabel => 'كلمة المرور الجديدة';

  @override
  String get newPasswordTextFieldHint => 'أدخل كلمة المرور الجديدة';

  @override
  String get newPasswordWeakErrorMessage => 'كلمة المرور الجديدة ضعيفة جدًا';

  @override
  String get newPasswordConfirmationTextFieldLabel => 'تأكيد كلمة المرور الجديدة';

  @override
  String get newPasswordConfirmationTextFieldHint => 'أعد إدخال كلمة المرور الجديدة';

  @override
  String get newPasswordConfirmationTextFieldError => 'كلمتا المرور غير متطابقتين';

  @override
  String get changePasswordInProgressButtonLabel => 'جارٍ تغيير كلمة المرور...';

  @override
  String get changePasswordButtonLabel => 'تغيير كلمة المرور';

  @override
  String get changePasswordSuccessMessage => 'تم تغيير كلمة المرور بنجاح';

  @override
  String get changePasswordFailureMessage => 'فشل تغيير كلمة المرور، حاول مرة أخرى';

  @override
  String get newPasswordTextFieldWeakPasswordErrorDescription => 'يجب أن تستوفي كلمة المرور المعايير التالية: - لا يقل طوله عن 8 أحرف - يحتوي على حرف كبير واحد على الأقل - يحتوي على حرف صغير واحد على الأقل - يحتوي على رقم واحد على الأقل - يحتوي على رمز واحد على الأقل (مثل @، \$، !، إلخ.)';
}
