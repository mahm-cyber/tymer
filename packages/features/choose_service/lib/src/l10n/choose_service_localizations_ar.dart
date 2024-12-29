import 'choose_service_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class ChooseServiceLocalizationsAr extends ChooseServiceLocalizations {
  ChooseServiceLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appBarTitle => 'طلب خدمة';

  @override
  String get skipWaitingListContainerTitle => 'تجاوز قائمة الانتظار';

  @override
  String get otherRequestContainerTitle => 'طلب آخر';

  @override
  String get otherRequestContainerSubtitle => 'اسأل عن شيء';
}
