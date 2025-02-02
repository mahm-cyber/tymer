import 'package:domain_models/src/file_dm.dart';
import 'package:equatable/equatable.dart';

class DateGroupedMessagesList extends Equatable {
  final List<DateGroupedMessages> list;

  const DateGroupedMessagesList({
    required this.list,
  });

  DateGroupedMessagesList copyWith({
    List<DateGroupedMessages>? list,
  }) {
    return DateGroupedMessagesList(
      list: list ?? this.list,
    );
  }

  @override
  List<Object?> get props => [list];
}

class DateGroupedMessages {
  final DateTime date;
  final List<ChatMessage> messages;

  DateGroupedMessages({
    required this.date,
    required this.messages,
  });

  DateGroupedMessages copyWith({
    DateTime? date,
    List<ChatMessage>? messages,
  }) {
    return DateGroupedMessages(
      date: date ?? this.date,
      messages: messages ?? this.messages,
    );
  }
}

class ChatMessage extends Equatable {
  final int id;
  final String? text;
  final List<FileDM>? files;
  final DateTime date;
  final Sender sender;
  final bool isSentByMe;

  const ChatMessage({
    required this.id,
    this.text,
    this.files,
    required this.date,
    required this.sender,
    this.isSentByMe = false,
  });

  ChatMessage copyWith({
    bool? isSentByMe,
  }) {
    return ChatMessage(
      id: id,
      text: text,
      files: files,
      date: date,
      sender: sender,
      isSentByMe: isSentByMe ?? this.isSentByMe,
    );
  }

  static ChatMessage get dummy => ChatMessage(
        id: -1,
        text: '',
        files: const [],
        date: DateTime.now(),
        sender: Sender(
          id: -1,
          name: '',
        ),
      );

  @override
  List<Object?> get props => [
        id,
        text,
        files,
        date,
        sender,
        isSentByMe,
      ];
}

class Sender {
  final int id;
  final String name;

  Sender({
    required this.id,
    required this.name,
  });
}
