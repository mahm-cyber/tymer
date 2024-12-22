import 'chat_localizations.dart';

/// The translations for English (`en`).
class ChatLocalizationsEn extends ChatLocalizations {
  ChatLocalizationsEn([super.locale = 'en']);

  @override
  String get appBarTitle => 'Talk To Support';

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

  @override
  String get chargedBackSnackBarMessage => 'Your money has been refunded';

  @override
  String get deniedSnackBarMessage => 'Your request has been denied';
}
