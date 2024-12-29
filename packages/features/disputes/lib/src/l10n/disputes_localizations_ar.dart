import 'disputes_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class DisputesLocalizationsAr extends DisputesLocalizations {
  DisputesLocalizationsAr([String locale = 'ar']) : super(locale);

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
