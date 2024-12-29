import 'disputes_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class DisputesLocalizationsEn extends DisputesLocalizations {
  DisputesLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarTitle => 'Disputes List';

  @override
  String distanceToServiceLocation(String meters) {
    return '$meters meters';
  }

  @override
  String get noDisputesIndicatorText => 'No disputes available';

  @override
  String get showInMapButtonLabel => 'Show in Map';

  @override
  String get viewButtonLabel => 'View';
}
