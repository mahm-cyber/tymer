import 'package:domain_models/src/file_dm.dart';
import 'package:equatable/equatable.dart';

class DateGroupedChat extends Equatable {
  final List<Chat> list;

  const DateGroupedChat({
    required this.list,
  });

  DateGroupedChat copyWith({
    List<Chat>? list,
  }) {
    return DateGroupedChat(
      list: list ?? this.list,
    );
  }

  @override
  List<Object?> get props => [list];
}

class Chat {
  final DateTime date;
  final List<DisputeMessage> messages;

  Chat({
    required this.date,
    required this.messages,
  });

  Chat copyWith({
    DateTime? date,
    List<DisputeMessage>? messages,
  }) {
    return Chat(
      date: date ?? this.date,
      messages: messages ?? this.messages,
    );
  }
}

class DisputeMessage {
  final int id;
  final String? text;
  final List<FileDM>? files;
  final DateTime date;
  final Sender sender;
  final bool isSentByMe;

  DisputeMessage({
    required this.id,
    this.text,
    this.files,
    required this.date,
    required this.sender,
    this.isSentByMe = false,
  });

  DisputeMessage copyWith({
    bool? isSentByMe,
  }) {
    return DisputeMessage(
      id: id,
      text: text,
      files: files,
      date: date,
      sender: sender,
      isSentByMe: isSentByMe ?? this.isSentByMe,
    );
  }
}

class Sender {
  final int id;
  final String name;

  Sender({
    required this.id,
    required this.name,
  });
}
