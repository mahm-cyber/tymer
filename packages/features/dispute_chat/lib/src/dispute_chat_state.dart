part of 'dispute_chat_cubit.dart';

class DisputeChatState extends Equatable {
  const DisputeChatState({
    this.files = const [],
    this.message,
    this.dateGroupedMessages,
    this.disputeChatFetchingStatus = DisputeChatFetchingStatus.initial,
    this.submissionStatus = DisputeChatSubmissionStatus.initial,
    this.userToken,
    this.dispute,
    this.disputeFetchStatus = DisputeFetchStatus.initial,
    this.error,
  });

  final List<FileSize<File?>> files;
  final String? message;
  final DateGroupedMessagesList? dateGroupedMessages;
  final DisputeChatFetchingStatus disputeChatFetchingStatus;
  final DisputeChatSubmissionStatus submissionStatus;
  final String? userToken;
  final Dispute? dispute;
  final DisputeFetchStatus disputeFetchStatus;
  final dynamic error;
  bool get isSendButtonDisabled =>
      (message?.isEmpty == true || message == null) && (files.isEmpty);

  DisputeChatState copyWith({
    List<FileSize<File?>>? files,
    String? message,
    DateGroupedMessagesList? dateGroupedMessages,
    DisputeChatFetchingStatus? disputeChatFetchingStatus,
    DisputeChatSubmissionStatus? submissionStatus,
    String? userToken,
    Dispute? dispute,
    DisputeFetchStatus? disputeFetchStatus,
    dynamic error,
  }) {
    return DisputeChatState(
      files: files ?? this.files,
      message: message ?? this.message,
      dateGroupedMessages: dateGroupedMessages ?? this.dateGroupedMessages,
      disputeChatFetchingStatus:
          disputeChatFetchingStatus ?? this.disputeChatFetchingStatus,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      userToken: userToken ?? this.userToken,
      dispute: dispute ?? this.dispute,
      disputeFetchStatus: disputeFetchStatus ?? this.disputeFetchStatus,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        files,
        message,
        dateGroupedMessages,
        disputeChatFetchingStatus,
        submissionStatus,
        userToken,
        dispute,
        disputeFetchStatus,
        error,
      ];
}

enum DisputeChatSubmissionStatus {
  initial,
  inProgress,
  success,
  failure,
}

enum DisputeChatFetchingStatus {
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
