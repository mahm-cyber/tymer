import 'provide_service_localizations.dart';

/// The translations for English (`en`).
class ProvideServiceLocalizationsEn extends ProvideServiceLocalizations {
  ProvideServiceLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarTitle => 'Requests List';

  @override
  String distanceToServiceLocation(String meters) {
    return '$meters meters';
  }

  @override
  String get noServiceRequestsText => 'No service requests available.';

  @override
  String get showInMapButtonLabel => 'Show in Map';

  @override
  String get viewButtonLabel => 'View';

  @override
  String get userHasRunningServiceRequestSnackBarMessage => 'You have a running service request. Please complete it before providing a new one';

  @override
  String get locationDataFailureSnackBarMessage => 'Failed to get location data. Please try again later';
}
