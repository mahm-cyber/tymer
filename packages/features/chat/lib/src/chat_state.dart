part of 'chat_cubit.dart';

class ChatState extends Equatable {
  const ChatState({
    this.files,
    this.message,
    this.dateGroupedChats,
    this.fetchingStatus = ChatFetchingStatus.initial,
    this.submissionStatus = ChatSubmissionStatus.initial,
    this.userToken,
  });

  final List<File>? files;
  final String? message;
  final DateGroupedChat? dateGroupedChats;
  final ChatFetchingStatus fetchingStatus;
  final ChatSubmissionStatus submissionStatus;
  final String? userToken;
  bool get isSendButtonDisabled =>
      (message?.isEmpty == true || message == null) &&
      (files?.isEmpty == true || files == null);


  ChatState copyWith({
    List<File>? files,
    String? message,
    DateGroupedChat? dateGroupedChats,
    ChatFetchingStatus? fetchingStatus,
    ChatSubmissionStatus? submissionStatus,
    String? userToken,
  }) {
    return ChatState(
      files: files ?? this.files,
      message: message ?? this.message,
      dateGroupedChats: dateGroupedChats ?? this.dateGroupedChats,
      fetchingStatus: fetchingStatus ?? this.fetchingStatus,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      userToken: userToken ?? this.userToken,
    );
  }

  @override
  List<Object?> get props => [
        files,
        message,
        dateGroupedChats,
        fetchingStatus,
        submissionStatus,
        userToken,
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
