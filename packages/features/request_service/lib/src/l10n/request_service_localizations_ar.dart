import 'request_service_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class RequestServiceLocalizationsAr extends RequestServiceLocalizations {
  RequestServiceLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get reservationServiceTypeAppBarTitle => 'قائمة الانتظار';

  @override
  String get otherServiceTypeAppBarTitle => 'طلب آخر';

  @override
  String get addressTextFieldLabel => 'العنوان*';

  @override
  String get datePickerTextFieldLabel => 'حدد التاريخ*';

  @override
  String get placeNameTextFieldLabel => 'اسم المكان*';

  @override
  String get requiredFieldErrorMessage => 'مطلوب*';

  @override
  String get reservationNameTextFieldLabel => 'اسم الحجز*';

  @override
  String get locationPickingCompletedButton => 'تم';

  @override
  String get locationPickerTextFieldLabel => 'اختر الموقع*';

  @override
  String get locationPickedTextFieldLabel => 'الموقع المختار';

  @override
  String get pricePickerTextFieldLabel => 'السعر*';

  @override
  String get requestServiceButtonInProgressLabel => 'جاري الطلب...';

  @override
  String get requestServiceButtonLabel => 'طلب الخدمة';

  @override
  String get insufficientBalanceMessage => 'رصيدك غير كاف. يرجى تعبئة الرصيد.';

  @override
  String get addFundsButtonLabel => 'اذهب إلى المحفظة';

  @override
  String get successfulServiceRequestMessage => 'تم طلب الخدمة بنجاح';

  @override
  String get selectServiceTypeLabel => 'اختر نوع الخدمة';

  @override
  String get additionalCommentsTextFieldLabel => 'تفاصيل إضافية';
}
