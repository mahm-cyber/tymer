import 'choose_service_localizations.dart';

/// The translations for English (`en`).
class ChooseServiceLocalizationsEn extends ChooseServiceLocalizations {
  ChooseServiceLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarTitle => 'Request Service';

  @override
  String get skipWaitingListContainerTitle => 'Skip waiting list';

  @override
  String get otherRequestContainerTitle => 'Other Request';

  @override
  String get otherRequestContainerSubtitle => 'Ask about something';
}
