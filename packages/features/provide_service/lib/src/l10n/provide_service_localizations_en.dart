import 'provide_service_localizations.dart';

/// The translations for English (`en`).
class ProvideServiceLocalizationsEn extends ProvideServiceLocalizations {
  ProvideServiceLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get reservationServiceTypeAppBarTitle => 'Waiting List';

  @override
  String get otherServiceTypeAppBarTitle => 'Other Request';

  @override
  String get addressTextFieldLabel => 'Address*';

  @override
  String get datePickerTextFieldLabel => 'Select Date*';

  @override
  String get placeNameTextFieldLabel => 'Place Name*';

  @override
  String get requiredFieldErrorMessage => 'This field is required.';

  @override
  String get reservationNameTextFieldLabel => 'Reservation Name*';

  @override
  String get locationPickingCompletedButton => 'Done';

  @override
  String get locationPickerTextFieldLabel => 'Pick Location*';

  @override
  String get locationPickedTextFieldLabel => 'Location Picked';

  @override
  String get pricePickerTextFieldLabel => 'Price';

  @override
  String get requestServiceButtonInProgressLabel => 'Requesting...';

  @override
  String get requestServiceButtonLabel => 'Request Service';
}
