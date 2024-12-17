import 'chat_localizations.dart';

/// The translations for English (`en`).
class ChatLocalizationsEn extends ChatLocalizations {
  ChatLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarTitle => 'Open Line Chat';

  @override
  String get uploadFileIconLabel => 'File';

  @override
  String get uploadImageFromGalleryIconLabel => 'Gallery';

  @override
  String get captureImageIconLabel => 'Capture';

  @override
  String get deleteFileIconLabel => 'Delete';

  @override
  String get noMessagesIndicator => 'No messages yet';

  @override
  String get messageSentByMeCardTitle => 'You';
}
