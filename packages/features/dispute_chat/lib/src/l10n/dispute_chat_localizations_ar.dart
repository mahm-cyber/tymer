import 'dispute_chat_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class DisputeChatLocalizationsAr extends DisputeChatLocalizations {
  DisputeChatLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appBarTitle => 'التحدث إلى الدعم';

  @override
  String get noMessagesIndicator => 'لا يوجد رسائل بعد';

  @override
  String get deniedSnackBarMessage => 'تم رفض طلبك';

  @override
  String get messageSentByMeCardTitle => 'أنت';

  @override
  String get refundedRequesterSnackBarMessage => 'تم استرداد أموالك';

  @override
  String get deniedRequesterSnackBarMessage => 'تم رفض طلبك';

  @override
  String get providerLostDisputeSnackBarMessage => 'تم استرداد الأموال لطالب الخدمة';

  @override
  String get providerWonDisputeSnackBarMessage => 'تم رفض الشكوى';

  @override
  String get attachmentSizeExceedsLimitErrorSnackBarMessage => 'يجب أن يكون حجم المرفق 1 ميجابايت أو أقل';
}
