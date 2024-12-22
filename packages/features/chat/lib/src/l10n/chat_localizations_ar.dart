import 'chat_localizations.dart';

/// The translations for Arabic (`ar`).
class ChatLocalizationsAr extends ChatLocalizations {
  ChatLocalizationsAr([super.locale = 'ar']);

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
  String get chargedBackSnackBarMessage => 'تم استرداد أموالك';

  @override
  String get deniedSnackBarMessage => 'تم رفض طلبك';
}
