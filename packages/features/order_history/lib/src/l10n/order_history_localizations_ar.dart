import 'order_history_localizations.dart';

/// The translations for Arabic (`ar`).
class OrderHistoryLocalizationsAr extends OrderHistoryLocalizations {
  OrderHistoryLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appBarTitle => 'قائمة الطلبات';

  @override
  String distanceToServiceLocation(String meters) {
    return '$meters متر';
  }

  @override
  String get noServiceRequestsText => 'لا توجد طلبات خدمة متاحة';

  @override
  String get showInMapButtonLabel => 'عرض على الخريطة';

  @override
  String get viewButtonLabel => 'عرض';

  @override
  String get fabLabel => 'النزاعات';
}
