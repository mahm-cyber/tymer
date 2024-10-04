import 'reset_password_localizations.dart';

/// The translations for Arabic (`ar`).
class ResetPasswordLocalizationsAr extends ResetPasswordLocalizations {
  ResetPasswordLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get resetPasswordSuccessMessage => 'تم إعادة تعيين كلمة المرور بنجاح';

  @override
  String get resetPasswordScreenTitle => 'إعادة ضبط كلمة المرور';

  @override
  String get resetPasswordScreenSubtitle => 'ادخل كلمة المرور الجديدة';

  @override
  String get submissionInProgressButtonLabel => 'جارٍ التقديم';

  @override
  String get submitButtonLabel => 'إرسال';

  @override
  String get newPasswordTextFieldLabel => 'كلمة المرور الجديدة';

  @override
  String get requiredFieldErrorMessage => 'مطلوب*';

  @override
  String get newPasswordTextFieldWeakPasswordError => 'كلمة المرور ضعيفة جدًا';

  @override
  String get newPasswordTextFieldHint => 'أدخل كلمة المرور الجديدة';

  @override
  String get newPasswordConfirmationTextFieldLabel => 'تأكيد كلمة المرور الجديدة';

  @override
  String get newPasswordConfirmationTextFieldHint => 'أعد إدخال كلمة المرور الجديدة';

  @override
  String get passwordConfirmationTextFieldDoesNotMatchError => 'كلمات المرور غير متطابقة';

  @override
  String get passwordTextFieldWeakPasswordErrorDescription => 'يجب أن تستوفي كلمة المرور المعايير التالية: - لا يقل طوله عن 6 أحرف - تحتوي على حرف كبير واحد على الأقل - تحتوي على حرف صغير واحد على الأقل - تحتوي على رقم واحد على الأقل - تحتوي على رمز واحد على الأقل (على سبيل المثال، @، \$، !، إلخ.)';
}
