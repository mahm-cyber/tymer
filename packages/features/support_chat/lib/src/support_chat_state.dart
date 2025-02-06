part of 'support_chat_cubit.dart';

class SupportChatState extends Equatable {
  const SupportChatState({
    this.chatId,
    this.supportChatClosed,
    this.supportChatExistenceCheckFetchStatus =
        SupportChatExistenceCheckFetchStatus.initial,
    this.supportChatCreationStatus = SupportChatCreationStatus.initial,
    this.files = const [],
    this.message,
    this.dateGroupedMessages,
    this.supportChatFetchingStatus = SupportChatFetchingStatus.initial,
    this.submissionStatus = SupportChatSubmissionStatus.initial,
    this.userToken,
    this.faqs,
  });

  final int? chatId;
  final bool? supportChatClosed;
  final SupportChatExistenceCheckFetchStatus
      supportChatExistenceCheckFetchStatus;
  final SupportChatCreationStatus supportChatCreationStatus;
  final List<FileSize<File?>> files;
  final String? message;
  final DateGroupedMessagesList? dateGroupedMessages;
  final SupportChatFetchingStatus supportChatFetchingStatus;
  final SupportChatSubmissionStatus submissionStatus;
  final String? userToken;
  final List<Faq>? faqs;  


  bool get isSendButtonDisabled =>
      (message?.isEmpty == true || message == null) && (files.isEmpty);

  SupportChatState copyWith({
    int? chatId,
    bool? supportChatClosed,
    SupportChatExistenceCheckFetchStatus?
        supportChatExistenceCheckFetchStatus,
    SupportChatCreationStatus? supportChatCreationStatus,
    List<FileSize<File?>>? files,
    String? message,
    DateGroupedMessagesList? dateGroupedMessages,
    SupportChatFetchingStatus? supportChatFetchingStatus,
    SupportChatSubmissionStatus? submissionStatus,
    String? userToken,
    List<Faq>? faqs,
  }) {
    return SupportChatState(
      chatId: chatId ?? this.chatId,
      supportChatClosed: supportChatClosed ?? this.supportChatClosed,
      supportChatExistenceCheckFetchStatus:
          supportChatExistenceCheckFetchStatus ??
              this.supportChatExistenceCheckFetchStatus,
      supportChatCreationStatus: supportChatCreationStatus ??
          this.supportChatCreationStatus,
      files: files ?? this.files,
      message: message ?? this.message,
      dateGroupedMessages: dateGroupedMessages ?? this.dateGroupedMessages,
      supportChatFetchingStatus:
          supportChatFetchingStatus ?? this.supportChatFetchingStatus,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      userToken: userToken ?? this.userToken,
      faqs: faqs ?? this.faqs,
    );
  }

  @override
  List<Object?> get props => [
        chatId,
        supportChatClosed,
        supportChatExistenceCheckFetchStatus,
        supportChatCreationStatus,
        files,
        message,
        dateGroupedMessages,
        supportChatFetchingStatus,
        submissionStatus,
        userToken,
        faqs,
      ];
}

enum SupportChatSubmissionStatus {
  initial,
  inProgress,
  success,
  failure,
}

enum SupportChatFetchingStatus {
  initial,
  inProgress,
  success,
  failure,
}

enum SupportChatExistenceCheckFetchStatus {
  initial,
  inProgress,
  success,
  failure,
}

enum SupportChatCreationStatus {
  initial,
  inProgress,
  success,
  failure,
}
