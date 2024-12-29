import 'chat_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class ChatLocalizationsEn extends ChatLocalizations {
  ChatLocalizationsEn([String locale = 'en']) : super(locale);

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
  String get refundedRequesterSnackBarMessage => 'Your money has been refunded';

  @override
  String get deniedRequesterSnackBarMessage => 'Your request has been denied';

  @override
  String get providerLostDisputeSnackBarMessage => 'Money has been refunded to the requester';

  @override
  String get providerWonDisputeSnackBarMessage => 'The requester\'s dispute was rejected';

  @override
  String get attachmentSizeExceedsLimitErrorSnackBarMessage => 'Attachment size should be 1MB or less';
}
