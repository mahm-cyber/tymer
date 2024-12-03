import 'provide_service_localizations.dart';

/// The translations for English (`en`).
class ProvideServiceLocalizationsEn extends ProvideServiceLocalizations {
  ProvideServiceLocalizationsEn([super.locale = 'en']);

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
  String get userHasRunningServiceRequestSnackBarMessage =>
      'You have a running service request. Please complete it before providing a new one';
}
