import 'verify_otp_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class VerifyOtpLocalizationsAr extends VerifyOtpLocalizations {
  VerifyOtpLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appBarTitle => 'النحقق من رقم الهاتف';

  @override
  String get verifyOtpTitle => 'أدخل الرمز للمتابعة';

  @override
  String get otpResentSuccessfullySnackBarMessage => 'تم إرسال الرمز بنجاح.';

  @override
  String get otpResentErrorSnackBarMessage => 'حدث خطأ أثناء إرسال الرمز.';

  @override
  String get otpVerifiedSuccessfullySnackBarMessage => 'تم التحقق من الهاتف بنجاح.';

  @override
  String get generalErrorSnackBarMessage => 'حدث خطأ ما';

  @override
  String get verifyOtpSubtitle => 'تم إرسال رمز التحقق إلى';

  @override
  String get requiredFieldErrorMessage => 'مطلوب*';

  @override
  String get incorrectOtpCodeErrorMessage => 'الرمز الذي أدخلته غير صحيح، حاول مرة أخرى';

  @override
  String get incompletePinErrorMessage => 'يرجى إدخال كود مكون من 6 أرقام';

  @override
  String get verifyingOtpButtonLabel => 'جارٍ التأكيد';

  @override
  String get verifyOtpButtonLabel => 'تأكيد';

  @override
  String get emailNotRegisteredErrorMessage => 'البريد الإلكتروني الذي أدخلته غير مسجل';

  @override
  String get resendOtpButtonLabel => 'إعادة إرسال OTP';

  @override
  String get newPasswordTextFieldLabel => 'كلمة المرور الجديدة';

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
  String get phoneAlreadyRegisteredErrorSnackBarMessage => 'رقم الهاتف الذي أدخلته مسجل بالفعل';

  @override
  String get passwordTextFieldWeakPasswordErrorDescription => 'يجب أن تستوفي كلمة المرور المعايير التالية: - لا يقل طوله عن 6 أحرف - تحتوي على حرف كبير واحد على الأقل - تحتوي على حرف صغير واحد على الأقل - تحتوي على رقم واحد على الأقل - تحتوي على رمز واحد على الأقل (على سبيل المثال، @، \$، !، إلخ.)';

  @override
  String get passwordResetSuccessfullySnackBarMessage => 'تم تغيير كلمة المرور بنجاح.';

  @override
  String get phoneChangedSuccessfullySnackBarMessage => 'تم تغيير رقم الهاتف بنجاح.';

  @override
  String otpRateLimitExceededErrorSnackBarMessage(Object seconds) {
    return 'لقد وصلت إلى الحد الأقصى لطلبات OTP. يرجى المحاولة مرة أخرى في $seconds ثانية.';
  }
}
