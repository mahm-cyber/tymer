import 'dart:isolate';
import 'dart:ui';

import 'package:chat/src/chat_cubit.dart';
import 'package:chat/src/components/message_card.dart';
import 'package:chat/src/l10n/chat_localizations.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:intl/intl.dart' as intl;

class MessagesList extends StatefulWidget {
  const MessagesList({
    super.key,
  });

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');

  }

  @override
  void dispose() {
    FlutterDownloader.cancelAll();
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        final loading = state.fetchingStatus == ChatFetchingStatus.inProgress;
        final error = state.fetchingStatus == ChatFetchingStatus.failure;
        final textTheme = Theme.of(context).textTheme;
        final cubit = context.read<ChatCubit>();
        final l10n = ChatLocalizations.of(context);
        final isSubmissionInProgress =
            state.submissionStatus == ChatSubmissionStatus.inProgress;

        return Expanded(
          child: loading
              ? const CenteredCircularProgressIndicator()
              : error
                  ? ExceptionIndicator(
                      onTryAgain: context.read<ChatCubit>().getChat,
                    )
                  : state.dateGroupedChats!.list.isEmpty
                      ? Center(
                          child: Text(
                            l10n.noMessagesIndicator,
                            style: textTheme.titleLarge,
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            context.read<ChatCubit>().getChat();
                          },
                          child: ListView.builder(
                            controller: cubit.scrollController,
                            itemCount: state.dateGroupedChats!.list.length,
                            itemBuilder: (context, index) {
                              final chat = state.dateGroupedChats!.list[index];
                              return Column(
                                children: [
                                  Text(
                                    intl.DateFormat('yyyy-MM-dd')
                                        .format(chat.date),
                                    style: textTheme.titleMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  ColumnBuilder(
                                    itemBuilder: (context, index) {
                                      final message = chat.messages[index];
                                      return MessageCard(
                                        isSubmissionInProgress:
                                            isSubmissionInProgress,
                                        message: message,
                                        userToken: state.userToken!,
                                        openFileInExternalApp: (url) {
                                          cubit.openFileInExternalApp(url);
                                        },
                                        isFirstElement: index == 0,
                                      );
                                    },
                                    itemCount: chat.messages.length,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
        );
      },
    );
  }
}
