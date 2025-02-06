import 'support_chat_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SupportChatLocalizationsEn extends SupportChatLocalizations {
  SupportChatLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarTitle => 'Support';

  @override
  String get startChatButtonLabel => 'Chat With Us';

  @override
  String get attachmentSizeExceedsLimitErrorSnackBarMessage => 'Attachment size should be 1MB or less';

  @override
  String get didntFindWhatYouAreLookingFor => 'Didn\'t find what you are looking for?';

  @override
  String get supportChatClosedSnackBarMessage => 'Support chat closed';

  @override
  String get faqsTitle => 'Frequently Asked Questions';
}
