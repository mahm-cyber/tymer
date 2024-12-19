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
