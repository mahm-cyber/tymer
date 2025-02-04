import 'home_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class HomeLocalizationsEn extends HomeLocalizations {
  HomeLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarTitle => 'Request or Provide a Service';

  @override
  String get requestServiceContainerTitle => 'Request Service';

  @override
  String get requestServiceContainerSubtitle => 'Save Time';

  @override
  String get provideServiceContainerTitle => 'Provide Service';

  @override
  String get provideServiceContainerSubtitle => 'Walk & Earn';

  @override
  String get fabLabel => 'Support';
}
