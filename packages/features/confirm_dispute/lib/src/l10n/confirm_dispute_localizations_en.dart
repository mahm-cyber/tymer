import 'confirm_dispute_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class ConfirmDisputeLocalizationsEn extends ConfirmDisputeLocalizations {
  ConfirmDisputeLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get disputeSuccessMessage => 'Ticket Placed successfully';

  @override
  String get disputeErrorMessage => 'Error Adding ticket';

  @override
  String get disputeMessageLabel => 'Ticket Reason';

  @override
  String get disputeButtonLabel => 'Confirm';
}
