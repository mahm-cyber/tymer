import 'package:chat/src/components/message_file_widget.dart';
import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({
    super.key,
    required this.isSubmissionInProgress,
    required this.message,
    required this.isFirstElement,
    required this.openFileInExternalApp,
    required this.userToken,

    // required this.downloadFile,
  });

  final bool isSubmissionInProgress;
  final ChatMessage message;
  final bool isFirstElement;
  final Function(String) openFileInExternalApp;
  final String userToken;



  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final isSentByMe = message.isSentByMe;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isFirstElement) VerticalGap.medium(),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(
            left: Spacing.medium,
            right: Spacing.medium,
            top: Spacing.small,
            bottom: Spacing.xSmall,
          ),
          margin: EdgeInsetsDirectional.only(
            bottom: Spacing.medium,
            end: isSentByMe ? theme.screenMargin : theme.screenMargin * 2,
            start: isSentByMe ? theme.screenMargin * 2 : theme.screenMargin,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: theme.borderColor),
            borderRadius: BorderRadius.circular(10),
            color: isSentByMe ? const Color(0xFFEFEFEF) : theme.secondaryColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (message.text != null &&
                        message.text?.isNotEmpty == true) ...[
                      SelectableText(
                        message.text!,
                        style: textTheme.bodyMedium?.copyWith(
                          color: isSentByMe
                              ? null
                              : theme.materialThemeData.colorScheme.surface,
                        ),
                      ),
                      VerticalGap.small(),
                    ],
                    if (message.files?.isNotEmpty == true) ...[
                      MessageFileWidget(
                        message: message,
                        openFileInExternalApp: openFileInExternalApp,
                        userToken: userToken,

                      ),
                      VerticalGap.small(),
                    ],
                    Row(
                      children: [
                        const Spacer(),
                        SelectableText(
                          message.date.formatDateTimeTo12Hour()!,
                          textDirection: TextDirection.ltr,
                          style: textTheme.bodySmall?.copyWith(
                            color: isSentByMe
                                ? const Color(0xFF797979)
                                : theme.materialThemeData.colorScheme.surface,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
