import 'confirm_dispute_localizations.dart';

/// The translations for Arabic (`ar`).
class ConfirmDisputeLocalizationsAr extends ConfirmDisputeLocalizations {
  ConfirmDisputeLocalizationsAr([super.locale = 'ar']);

  @override
  String get disputeSuccessMessage => 'تم تقديم النزاع بنجاح';

  @override
  String get disputeErrorMessage => 'خطأ في تقديم النزاع';

  @override
  String get disputeMessageLabel => 'سبب النزاع';

  @override
  String get disputeButtonLabel => 'تأكيد';
}
