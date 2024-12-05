import 'disputes_localizations.dart';

/// The translations for English (`en`).
class DisputesLocalizationsEn extends DisputesLocalizations {
  DisputesLocalizationsEn([super.locale = 'en']);

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
