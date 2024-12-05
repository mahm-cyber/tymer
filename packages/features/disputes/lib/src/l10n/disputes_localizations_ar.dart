import 'disputes_localizations.dart';

/// The translations for Arabic (`ar`).
class DisputesLocalizationsAr extends DisputesLocalizations {
  DisputesLocalizationsAr([super.locale = 'ar']);

  @override
  String get appBarTitle => 'قائمة النزاعات';

  @override
  String distanceToServiceLocation(String meters) {
    return '$meters متر';
  }

  @override
  String get noDisputesIndicatorText => 'لا توجد نزاعات متاحة';

  @override
  String get showInMapButtonLabel => 'عرض على الخريطة';

  @override
  String get viewButtonLabel => 'عرض';
}
