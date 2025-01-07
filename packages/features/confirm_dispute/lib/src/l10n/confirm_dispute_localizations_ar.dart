import 'confirm_dispute_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class ConfirmDisputeLocalizationsAr extends ConfirmDisputeLocalizations {
  ConfirmDisputeLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get disputeSuccessMessage => 'تم طلب الشكوى بنجاح';

  @override
  String get disputeErrorMessage => 'خطأ في طلب الشكوى';

  @override
  String get disputeMessageLabel => 'سبب الشكوى';

  @override
  String get disputeButtonLabel => 'تأكيد';
}
