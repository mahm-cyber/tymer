import 'service_request_status_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class ServiceRequestStatusLocalizationsAr extends ServiceRequestStatusLocalizations {
  ServiceRequestStatusLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appBarTitle => 'حالة الطلب';

  @override
  String get findingSomeoneStepTitle => 'جاري العثور على شخص';

  @override
  String get processingStepTitle => 'جاري المعالجة';

  @override
  String get completeStepTitle => 'اكتمل';

  @override
  String get requestDoneContainerTitle => 'تم الانتهاء من طلبك';

  @override
  String get yesButtonLabel => 'نعم';

  @override
  String get noButtonLabel => 'لا';

  @override
  String get cancelButtonLabel => 'إلغاء';

  @override
  String get cancellationSuccessMessage => 'تم إلغاء طلبك بنجاح';

  @override
  String get cancellationErrorMessage => 'حدث خطأ أثناء إلغاء طلبك';

  @override
  String get confirmationSuccessMessage => 'تم تأكيد طلبك بنجاح';

  @override
  String get confirmationErrorMessage => 'حدث خطأ أثناء تأكيد طلبك';

  @override
  String get backHomeButtonLabel => 'العودة إلى الرئيسية';

  @override
  String get reservationNumberTextFieldLabel => 'رقم الحجز';

  @override
  String get dateTextFieldLabel => 'التاريخ';

  @override
  String get timeTextFieldLabel => 'الوقت';

  @override
  String get additionalNotesTextFieldLabel => 'ملاحظات إضافية';

  @override
  String get serviceRequestAlreadyCancelledMessage => 'تم إلغاء هذا الطلب من قبل';
}
