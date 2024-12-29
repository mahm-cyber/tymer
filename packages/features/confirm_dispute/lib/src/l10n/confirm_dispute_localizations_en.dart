import 'confirm_dispute_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class ConfirmDisputeLocalizationsEn extends ConfirmDisputeLocalizations {
  ConfirmDisputeLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get disputeSuccessMessage => 'Dispute requested successfully';

  @override
  String get disputeErrorMessage => 'Error requesting dispute';

  @override
  String get disputeMessageLabel => 'Dispute Reason';

  @override
  String get disputeButtonLabel => 'Confirm';
}
