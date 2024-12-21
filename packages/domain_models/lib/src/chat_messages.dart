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
  final List<DisputeMessage> messages;

  DateGroupedMessages({
    required this.date,
    required this.messages,
  });

  DateGroupedMessages copyWith({
    DateTime? date,
    List<DisputeMessage>? messages,
  }) {
    return DateGroupedMessages(
      date: date ?? this.date,
      messages: messages ?? this.messages,
    );
  }
}

class DisputeMessage extends Equatable {
  final int id;
  final String? text;
  final List<FileDM>? files;
  final DateTime date;
  final Sender sender;
  final bool isSentByMe;

  const DisputeMessage({
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

  static DisputeMessage get dummy => DisputeMessage(
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
