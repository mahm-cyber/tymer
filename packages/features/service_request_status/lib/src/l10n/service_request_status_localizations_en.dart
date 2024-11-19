import 'service_request_status_localizations.dart';

/// The translations for English (`en`).
class ServiceRequestStatusLocalizationsEn extends ServiceRequestStatusLocalizations {
  ServiceRequestStatusLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarTitle => 'Request Status';

  @override
  String get findingSomeoneStepTitle => 'Finding Someone';

  @override
  String get processingStepTitle => 'Processing';

  @override
  String get completeStepTitle => 'Complete';

  @override
  String get requestDoneContainerTitle => 'Is your request done?';

  @override
  String get yesButtonLabel => 'Yes';

  @override
  String get noButtonLabel => 'No';

  @override
  String get cancelButtonLabel => 'Cancel';

  @override
  String get cancellationSuccessMessage => 'Your request has been cancelled';

  @override
  String get cancellationErrorMessage => 'There was an error cancelling your request';

  @override
  String get confirmationSuccessMessage => 'Your request has been confirmed';

  @override
  String get confirmationErrorMessage => 'There was an error confirming your request';

  @override
  String get backHomeButtonLabel => 'Back to Home';
}
