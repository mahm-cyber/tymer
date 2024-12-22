import 'package:chat/src/chat_cubit.dart';
import 'package:chat/src/components/message_card.dart';
import 'package:chat/src/l10n/chat_localizations.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:intl/intl.dart' as intl;

class MessagesList extends StatelessWidget {
  const MessagesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        final loading =
            state.chatFetchingStatus == ChatFetchingStatus.inProgress ||
                state.disputeFetchStatus == DisputeFetchStatus.inProgress;
        final error = state.chatFetchingStatus == ChatFetchingStatus.failure;
        final textTheme = Theme.of(context).textTheme;
        final cubit = context.read<ChatCubit>();
        final l10n = ChatLocalizations.of(context);
        final isSubmissionInProgress =
            state.submissionStatus == ChatSubmissionStatus.inProgress;
        final locale = Localizations.localeOf(context);
        return Expanded(
          child: loading
              ? const CenteredCircularProgressIndicator()
              : error
                  ? ExceptionIndicator(
                      onTryAgain: context.read<ChatCubit>().getChat,
                    )
                  : state.dateGroupedMessages!.list.isEmpty
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
                            itemCount: state.dateGroupedMessages!.list.length,
                            itemBuilder: (context, index) {
                              final chat =
                                  state.dateGroupedMessages!.list[index];
                              return Column(
                                children: [
                                  Text(
                                    intl.DateFormat('yyyy-MM-dd')
                                        .format(chat.date)
                                        .localizeDateString(locale),
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
