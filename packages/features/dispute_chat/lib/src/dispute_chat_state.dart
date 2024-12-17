part of 'dispute_chat_cubit.dart';

class DisputeChatState extends Equatable {
  const DisputeChatState({
    this.userToken = '',
    this.messagesFetchStatus = FetchStatus.idle,
    this.messages,
    this.user,
  });

  final String userToken;
  final FetchStatus messagesFetchStatus;
  final List<types.Message>? messages;
  final types.User? user;

  DisputeChatState copyWith({
    String? userToken,
    FetchStatus? messagesFetchStatus,
    List<types.Message>? messages,
    types.User? user,
  }) {
    return DisputeChatState(
      userToken: userToken ?? this.userToken,
      messagesFetchStatus: messagesFetchStatus ?? this.messagesFetchStatus,
      messages: messages ?? this.messages,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        userToken,
        messagesFetchStatus,
        messages,
        user,
      ];
}

enum FetchStatus {
  idle,
  inProgress,
  success,
  failure,
}
