import 'confirm_dispute_localizations.dart';

/// The translations for English (`en`).
class ConfirmDisputeLocalizationsEn extends ConfirmDisputeLocalizations {
  ConfirmDisputeLocalizationsEn([super.locale = 'en']);

  @override
  String get disputeSuccessMessage => 'Dispute submitted successfully';

  @override
  String get disputeErrorMessage => 'Error submitting dispute';

  @override
  String get disputeMessageLabel => 'Dispute Reason';

  @override
  String get disputeButtonLabel => 'Confirm';
}
