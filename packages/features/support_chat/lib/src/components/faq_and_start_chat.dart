import 'package:component_library/component_library.dart';
import 'package:support_chat/support_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_chat/src/support_chat_cubit.dart';

class FaqAndStartChat extends StatelessWidget {
  const FaqAndStartChat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SupportChatCubit>();
    final l10n = SupportChatLocalizations.of(context);
    return BlocBuilder<SupportChatCubit, SupportChatState>(
      builder: (context, state) {
        final supportChatCreateInProgress = state.supportChatCreationStatus ==
            SupportChatCreationStatus.inProgress;
        final theme = TymerTheme.of(context);
        final textTheme = Theme.of(context).textTheme;
        return Center(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
            shrinkWrap: true,
            children: [
              ...List.generate(
                state.faqs?.length ?? 0,
                (index) => ExpansionTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    side: const BorderSide(color: Colors.black),
                  ),
                  collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    side: const BorderSide(color: Colors.black),
                  ),
                  title: Text(
                    state.faqs![index].question,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  children: [
                    Text(
                      state.faqs![index].answer,
                      style: textTheme.bodyMedium?.copyWith(
                        color: theme.primaryColor,
                      ),
                    ),
                    VerticalGap.medium(),
                  ],
                ),
              ),
              VerticalGap.medium(),
              Center(
                child: Text(
                  l10n.didntFindWhatYouAreLookingFor,
                  textAlign: TextAlign.center,
                ),
              ),
              VerticalGap.medium(),
              Center(
                child: TextButton.icon(
                  onPressed: supportChatCreateInProgress
                      ? null
                      : cubit.createSupportChat,
                  icon: const Icon(Icons.chat),
                  label: Text(l10n.startChatButtonLabel),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
