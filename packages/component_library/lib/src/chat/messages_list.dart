import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:intl/intl.dart' as intl;

class MessagesList extends StatelessWidget {
  const MessagesList({
    super.key,
    required this.dateGroupedMessages,
    required this.submissionInProgress,
    required this.sendMessage,
    required this.onMessageChanged,
    required this.loading,
    required this.error,
    required this.scrollController,
    required this.userToken,
  });

  final List<DateGroupedMessages> dateGroupedMessages;
  final bool submissionInProgress;
  final Function sendMessage;
  final Function onMessageChanged;
  final bool loading;
  final bool error;
  final ScrollController scrollController;
  final String userToken;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = ComponentLibraryLocalizations.of(context);
    final locale = Localizations.localeOf(context);

    return Expanded(
      child: loading
          ? const CenteredCircularProgressIndicator()
          : error
              ? ExceptionIndicator(
                  onTryAgain: () => sendMessage(),
                )
              : dateGroupedMessages.isEmpty
                  ? Center(
                      child: Text(
                        l10n.noMessagesIndicator,
                        style: textTheme.titleLarge,
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        sendMessage();
                      },
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: dateGroupedMessages.length,
                        itemBuilder: (context, index) {
                          final chat = dateGroupedMessages[index];
                          return Column(
                            children: [
                              Text(
                                intl.DateFormat('dd-MM-yyyy')
                                    .format(chat.date)
                                    .localizeDateString(locale),
                                textDirection: TextDirection.rtl,
                                style: textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              ColumnBuilder(
                                itemBuilder: (context, index) {
                                  final message = chat.messages[index];
                                  return MessageCard(
                                    isSubmissionInProgress:
                                        submissionInProgress,
                                    message: message,
                                    userToken:
                                        userToken, // Assuming userToken is passed in constructor
                                    openFileInExternalApp: (url) {
                                      // Handle opening file in external app
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
  }
}
