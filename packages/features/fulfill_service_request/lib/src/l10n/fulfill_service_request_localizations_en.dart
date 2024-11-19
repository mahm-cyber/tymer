import 'fulfill_service_request_localizations.dart';

/// The translations for English (`en`).
class FulfillServiceRequestLocalizationsEn extends FulfillServiceRequestLocalizations {
  FulfillServiceRequestLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get submitButtonLabel => 'Submit';

  @override
  String get serviceDetailsTitle => 'Request Details';

  @override
  String get bottomSheetGalleryButton => 'Gallery';

  @override
  String get bottomSheetCaptureButton => 'Capture';

  @override
  String get imageTextFieldLabel => 'Image';

  @override
  String get additionalDetailsTextFieldLabel => 'Additional Details';

  @override
  String get reservationNumberTextFieldLabel => 'Reservation Number';

  @override
  String get requiredFieldErrorMessage => 'This field is required.';

  @override
  String get timeTextFieldLabel => 'Time';

  @override
  String get dayTextFieldLabel => 'Day';

  @override
  String get serviceRequestSuccessMessage => 'Request fulfilled successfully';

  @override
  String get serviceRequestFailureMessage => 'Failed, try again';

  @override
  String get backHomeButtonLabel => 'Back to Home';

  @override
  String get serviceFeesContainerLabel => 'Service Fees';

  @override
  String get awaitingConfirmationButtonLabel => 'Awaiting Confirmation';
}
