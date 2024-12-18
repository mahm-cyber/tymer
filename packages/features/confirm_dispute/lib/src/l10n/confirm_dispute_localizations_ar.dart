import 'confirm_dispute_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class ConfirmDisputeLocalizationsAr extends ConfirmDisputeLocalizations {
  ConfirmDisputeLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get disputeSuccessMessage => 'تم تقديم النزاع بنجاح';

  @override
  String get disputeErrorMessage => 'خطأ في تقديم النزاع';

  @override
  String get disputeMessageLabel => 'سبب النزاع';

  @override
  String get disputeButtonLabel => 'تأكيد';
}
