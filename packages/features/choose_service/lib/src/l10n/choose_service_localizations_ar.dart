import 'choose_service_localizations.dart';

/// The translations for Arabic (`ar`).
class ChooseServiceLocalizationsAr extends ChooseServiceLocalizations {
  ChooseServiceLocalizationsAr([super.locale = 'ar']);

  @override
  String get appBarTitle => 'طلب خدمة';

  @override
  String get skipWaitingListContainerTitle => 'تجاوز قائمة الانتظار';

  @override
  String get otherRequestContainerTitle => 'طلب آخر';

  @override
  String get otherRequestContainerSubtitle => 'اسأل عن شيء';
}
