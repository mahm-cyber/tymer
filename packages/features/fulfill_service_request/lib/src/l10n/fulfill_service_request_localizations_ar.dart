import 'fulfill_service_request_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class FulfillServiceRequestLocalizationsAr extends FulfillServiceRequestLocalizations {
  FulfillServiceRequestLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get submitButtonLabel => 'إرسال';

  @override
  String get serviceDetailsTitle => 'تفاصيل الطلب';

  @override
  String get bottomSheetGalleryButton => 'معرض';

  @override
  String get bottomSheetCaptureButton => 'التقاط';

  @override
  String get imageTextFieldLabel => 'صورة';

  @override
  String get additionalDetailsTextFieldLabel => 'تفاصيل إضافية';

  @override
  String get reservationNumberTextFieldLabel => 'رقم الحجز';

  @override
  String get requiredFieldErrorMessage => 'مطلوب*';

  @override
  String get timeTextFieldLabel => 'الوقت';

  @override
  String get dayTextFieldLabel => 'اليوم';

  @override
  String get serviceRequestSuccessMessage => 'تم تنفيذ الطلب بنجاح';

  @override
  String get serviceRequestFailureMessage => 'فشل، حاول مرة أخرى';

  @override
  String get backHomeButtonLabel => 'العودة إلى الصفحة الرئيسية';

  @override
  String get serviceFeesContainerLabel => 'رسوم الخدمة';

  @override
  String get awaitingConfirmationButtonLabel => 'جارى التأكيد';
}
