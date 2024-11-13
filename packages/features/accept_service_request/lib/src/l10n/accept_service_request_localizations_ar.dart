import 'accept_service_request_localizations.dart';

/// The translations for Arabic (`ar`).
class AcceptServiceRequestLocalizationsAr extends AcceptServiceRequestLocalizations {
  AcceptServiceRequestLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appBarTitle => 'تفاصيل الطلب';

  @override
  String get reservedForTextFieldLabel => 'محجوز لـ';

  @override
  String get dateTextFieldLabel => 'التاريخ';

  @override
  String get placeNameTextFieldLabel => 'اسم المكان';

  @override
  String get placeAddressTextFieldLabel => 'عنوان المكان';

  @override
  String get locationTextFieldLabel => 'الموقع';

  @override
  String get priceTextFieldLabel => 'السعر';

  @override
  String get additionalCommentsTextFieldLabel => 'تعليقات إضافية';

  @override
  String get acceptButtonLabel => 'قبول';

  @override
  String distanceToServiceLocation(String meters) {
    return '$meters متر';
  }

  @override
  String get myLocationInfoWindowTitle => 'موقعي';
}
