import 'accept_service_request_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AcceptServiceRequestLocalizationsEn extends AcceptServiceRequestLocalizations {
  AcceptServiceRequestLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarTitle => 'Request Details';

  @override
  String get reservedForTextFieldLabel => 'Reserved For';

  @override
  String get dateTextFieldLabel => 'Date';

  @override
  String get placeNameTextFieldLabel => 'Place Name';

  @override
  String get placeAddressTextFieldLabel => 'Place Address';

  @override
  String get locationTextFieldLabel => 'Location';

  @override
  String get priceTextFieldLabel => 'Price';

  @override
  String get additionalCommentsTextFieldLabel => 'Additional Comments';

  @override
  String get acceptButtonLabel => 'Accept';

  @override
  String distanceToServiceLocation(String meters) {
    return '$meters meters';
  }

  @override
  String get myLocationMarkerTitle => 'my-location';

  @override
  String get myLocationInfoWindowTitle => 'My Location';

  @override
  String get serviceRequestNotAvailableAnymoreErrorMessage => 'Request is no longer available';
}
