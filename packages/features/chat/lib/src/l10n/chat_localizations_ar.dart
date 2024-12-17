import 'chat_localizations.dart';

/// The translations for Arabic (`ar`).
class ChatLocalizationsAr extends ChatLocalizations {
  ChatLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appBarTitle => 'الرسائل';

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
}
