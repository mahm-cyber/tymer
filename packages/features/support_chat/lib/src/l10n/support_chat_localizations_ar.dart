import 'support_chat_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class SupportChatLocalizationsAr extends SupportChatLocalizations {
  SupportChatLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appBarTitle => 'الدعم';

  @override
  String get startChatButtonLabel => 'تحدث معنا';

  @override
  String get attachmentSizeExceedsLimitErrorSnackBarMessage => 'يجب أن يكون حجم المرفق 1 ميجابايت أو أقل';

  @override
  String get didntFindWhatYouAreLookingFor => 'لم تجد ما تبحث عنه؟';
}
