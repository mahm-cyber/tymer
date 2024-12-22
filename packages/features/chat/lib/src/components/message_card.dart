import 'package:chat/src/components/message_file_widget.dart';
import 'package:chat/src/l10n/chat_localizations.dart';
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
  final DisputeMessage message;
  final bool isFirstElement;
  final Function(String) openFileInExternalApp;
  final String userToken;

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final isSentByMe = message.isSentByMe;
    final l10n = ChatLocalizations.of(context);
    final isFirstLetterArabic = message.text?.isFirstLetterArabic() == true;
    final time = TimeOfDay.fromDateTime(message.date)
        .localizedTimeOfDay(Localizations.localeOf(context));
    final sentByMeTime =
        '${time.split(' ')[0].split('').reversed.join('')} ${time.split(' ')[1]}';
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return Row(
      children: [
        if (!isSentByMe) const Spacer(),
        Container(
          constraints: BoxConstraints(
              maxWidth:
                  MediaQuery.of(context).size.width - (theme.screenMargin * 3)),
          padding: const EdgeInsets.only(
            left: Spacing.medium,
            right: Spacing.medium,
            top: Spacing.small,
            bottom: Spacing.xSmall,
          ),
          margin: EdgeInsetsDirectional.only(
            bottom: Spacing.medium,
            start: isSentByMe ? theme.screenMargin : theme.screenMargin * 2,
            end: isSentByMe ? theme.screenMargin * 2 : theme.screenMargin,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: theme.borderColor),
            borderRadius: BorderRadius.circular(10),
            color: isSentByMe ? const Color(0xFFEFEFEF) : theme.secondaryColor,
          ),
          child: Column(
            crossAxisAlignment:
                isSentByMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              Text(
                isSentByMe
                    ? l10n.messageSentByMeCardTitle
                    : message.sender.name,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isSentByMe
                      ? theme.materialThemeData.colorScheme.secondary
                      : theme.materialThemeData.colorScheme.surface,
                ),
              ),
              VerticalGap.medium(),
              if (message.text != null && message.text?.isNotEmpty == true) ...[
                SelectableText(
                  message.text!,
                  textDirection: isFirstLetterArabic
                      ? TextDirection.rtl
                      : TextDirection.ltr,
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
              SelectableText(
                isSentByMe && isArabic ? sentByMeTime : time,
                textDirection: TextDirection.ltr,
                style: textTheme.labelMedium?.copyWith(
                  color: isSentByMe
                      ? const Color(0xFF797979)
                      : theme.materialThemeData.colorScheme.surface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
