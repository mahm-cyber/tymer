import 'home_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class HomeLocalizationsAr extends HomeLocalizations {
  HomeLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appBarTitle => 'طلب أو تقديم خدمة';

  @override
  String get requestServiceContainerTitle => 'طلب خدمة';

  @override
  String get requestServiceContainerSubtitle => 'وفر الوقت';

  @override
  String get provideServiceContainerTitle => 'تقديم خدمة';

  @override
  String get provideServiceContainerSubtitle => 'امشِ واكسب';
}
