part of 'chat_cubit.dart';

class ChatState extends Equatable {
  const ChatState({
    this.files,
    this.message,
    this.dateGroupedMessages,
    this.chatFetchingStatus = ChatFetchingStatus.initial,
    this.submissionStatus = ChatSubmissionStatus.initial,
    this.userToken,
    this.dispute,
    this.disputeFetchStatus = DisputeFetchStatus.initial,
  });

  final List<File>? files;
  final String? message;
  final DateGroupedMessagesList? dateGroupedMessages;
  final ChatFetchingStatus chatFetchingStatus;
  final ChatSubmissionStatus submissionStatus;
  final String? userToken;
  final Dispute? dispute;
  final DisputeFetchStatus disputeFetchStatus;
  bool get isSendButtonDisabled =>
      (message?.isEmpty == true || message == null) &&
      (files?.isEmpty == true || files == null);


  ChatState copyWith({
    List<File>? files,
    String? message,
    DateGroupedMessagesList? dateGroupedMessages,
    ChatFetchingStatus? chatFetchingStatus,
    ChatSubmissionStatus? submissionStatus,
    String? userToken,
    Dispute? dispute,
    DisputeFetchStatus? disputeFetchStatus,
  }) {
    return ChatState(
      files: files ?? this.files,
      message: message ?? this.message,
      dateGroupedMessages: dateGroupedMessages ?? this.dateGroupedMessages,
      chatFetchingStatus: chatFetchingStatus ?? this.chatFetchingStatus,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      userToken: userToken ?? this.userToken,
      dispute: dispute ?? this.dispute,
      disputeFetchStatus: disputeFetchStatus ?? this.disputeFetchStatus,
    );
  }

  @override
  List<Object?> get props => [
        files,
        message,
        dateGroupedMessages,
        chatFetchingStatus,
        submissionStatus,
        userToken,
        dispute,
        disputeFetchStatus,
      ];
}

enum ChatSubmissionStatus {
  initial,
  inProgress,
  success,
  failure,
}

enum ChatFetchingStatus {
  initial,
  inProgress,
  success,
  failure,
}

enum DisputeFetchStatus {
  initial,
  inProgress,
  success,
  failure,
}