import 'dispute_chat_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class DisputeChatLocalizationsEn extends DisputeChatLocalizations {
  DisputeChatLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarTitle => 'Dispute Chat';

  @override
  String get noMessagesIndicator => 'No messages yet';

  @override
  String get deniedSnackBarMessage => 'Your request has been denied';

  @override
  String get messageSentByMeCardTitle => 'You';

  @override
  String get refundedRequesterSnackBarMessage => 'Your money has been refunded';

  @override
  String get deniedRequesterSnackBarMessage => 'Your request has been denied';

  @override
  String get providerLostDisputeSnackBarMessage => 'Money has been refunded to the requester';

  @override
  String get providerWonDisputeSnackBarMessage => 'Ticker has been rejected';

  @override
  String get attachmentSizeExceedsLimitErrorSnackBarMessage => 'Attachment size should be 1MB or less';
}
