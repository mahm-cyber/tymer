import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_chat/src/support_chat_cubit.dart';

class SupportChat extends StatelessWidget {
  const SupportChat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SupportChatCubit>();
    return BlocBuilder<SupportChatCubit, SupportChatState>(
      builder: (context, state) {
        final loading = state.supportChatFetchingStatus ==
            SupportChatFetchingStatus.inProgress;
        final error = state.supportChatFetchingStatus ==
            SupportChatFetchingStatus.failure;
        if (loading) {
          return const CenteredCircularProgressIndicator();
        }
        if (error) {
          return ExceptionIndicator(
            onTryAgain: () => cubit.getSupportChat(chatId: state.chatId!),
          );
        }
        return Column(
          children: [
            MessagesList(
              userToken: state.userToken ?? '',
              dateGroupedMessages: state.dateGroupedMessages?.list ?? [],
              submissionInProgress: state.submissionStatus ==
                  SupportChatSubmissionStatus.inProgress,
              sendMessage: cubit.sendMessage,
              onMessageChanged: cubit.onMessageChanged,
              loading: state.supportChatFetchingStatus ==
                      SupportChatFetchingStatus.inProgress ||
                  state.dateGroupedMessages == null,
              error: state.supportChatFetchingStatus ==
                  SupportChatFetchingStatus.failure,
              scrollController: cubit.scrollController,
            ),
            SendMessage(
              messageController: cubit.messageController,
              submissionInProgress: state.submissionStatus ==
                  SupportChatSubmissionStatus.inProgress,
              files: state.files, // Assuming state.files is the list of files
              isSendButtonDisabled: state.isSendButtonDisabled,
              onSendMessage: cubit.sendMessage,
              onMessageChanged: cubit.onMessageChanged,
              onDeletePickedFile: cubit.deletePickedFile,
              onPickFile: cubit.pickFile,
              onPickImageFromGallery: cubit.pickImageFromGallery,
              onCapturePhoto: cubit.capturePhoto,
            ),
          ],
        );
      },
    );
  }
}
