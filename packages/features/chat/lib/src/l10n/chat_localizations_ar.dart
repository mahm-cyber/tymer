import 'chat_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class ChatLocalizationsAr extends ChatLocalizations {
  ChatLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appBarTitle => 'التحدث إلى الدعم';

  @override
  String get uploadFileIconLabel => 'ملف';

  @override
  String get uploadImageFromGalleryIconLabel => 'صورة';

  @override
  String get captureImageIconLabel => 'كاميرا';

  @override
  String get deleteFileIconLabel => 'حذف';

  @override
  String get noMessagesIndicator => 'لا توجد رسائل بعد';

  @override
  String get messageSentByMeCardTitle => 'أنت';

  @override
  String get refundedRequesterSnackBarMessage => 'تم استرداد أموالك';

  @override
  String get deniedRequesterSnackBarMessage => 'تم رفض طلبك';

  @override
  String get providerLostDisputeSnackBarMessage => 'تم استرداد الأموال لطالب الخدمة';

  @override
  String get providerWonDisputeSnackBarMessage => 'تم رفض النزاع الخاص بطالب الخدمة';

  @override
  String get attachmentSizeExceedsLimitErrorSnackBarMessage => 'يجب أن يكون حجم المرفق 1 ميجابايت أو أقل';
}
