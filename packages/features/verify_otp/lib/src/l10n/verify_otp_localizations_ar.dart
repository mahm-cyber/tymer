import 'verify_otp_localizations.dart';

/// The translations for Arabic (`ar`).
class VerifyOtpLocalizationsAr extends VerifyOtpLocalizations {
  VerifyOtpLocalizationsAr([super.locale = 'ar']);

  @override
  String get verifyOtpTitle => 'تفقد بريدك الإلكتروني !';

  @override
  String get otpResentSuccessfullySnackBarMessage => 'تم إرسال الرمز بنجاح';

  @override
  String get otpResentErrorSnackBarMessage => 'حدث خطأ أثناء إرسال الرمز';

  @override
  String get otpVerifiedSuccessfullySnackBarMessage => 'تم تأكيد الرمز بنجاح';

  @override
  String get generalErrorSnackBarMessage => 'حدث خطأ ما';

  @override
  String get verifyOtpSubtitle => 'يرجى التحقق من بريدك الإلكتروني لإعادة تعيين كلمة المرور الخاصة بك';

  @override
  String get requiredFieldErrorMessage => 'مطلوب*';

  @override
  String get incorrectOtpCodeErrorMessage => 'الرمز الذي أدخلته غير صحيح، حاول مرة أخرى';

  @override
  String get verifyingOtpButtonLabel => 'جارٍ التأكيد';

  @override
  String get verifyOtpButtonLabel => 'تأكيد الرمز';

  @override
  String get emailNotRegisteredErrorMessage => 'البريد الإلكتروني الذي أدخلته غير مسجل';

  @override
  String get resendOtpButtonLabel => 'إعادة إرسال OTP';

  @override
  String get changeEmailSubtitle => 'يرجى التحقق من بريدك الإلكتروني لإعادة تعيين البريد الإلكتروني الخاصة بك';

  @override
  String get otpLimitCrossedErrorSnackBarMessage => 'تجاوز الحد الأقصى لمحاولات التحقق من الرمز';
}
