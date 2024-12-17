import 'package:chat/src/chat_cubit.dart';
import 'package:chat/src/l10n/chat_localizations.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendMessage extends StatefulWidget {
  const SendMessage({super.key});

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  bool attachVisible = false;

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final l10n = ChatLocalizations.of(context);
    final cubit = context.read<ChatCubit>();
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        final submissionInProgress =
            state.submissionStatus == ChatSubmissionStatus.inProgress;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: attachVisible ? 150 : 60,
          padding: EdgeInsets.symmetric(
            horizontal: theme.screenMargin,
            vertical: Spacing.small,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFFF4F4F4),
          ),
          child: ListView(
            children: [
              SizedBox(
                height: 40,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        scrollPadding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom +
                                16 * 4),
                        controller: cubit.messageController,
                        enabled: !submissionInProgress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: Spacing.medium,
                          ),
                        ),
                        onEditingComplete: cubit.sendMessage,
                        onChanged: cubit.onMessageChanged,
                      ),
                    ),
                    HorizontalGap.medium(),
                    Stack(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.attach_file),
                          onPressed: () {
                            attachVisible = !attachVisible;
                            setState(() {});
                          },
                        ),
                        if (state.files != null)
                          PositionedDirectional(
                            start: 0,
                            top: 0,
                            child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.attach_file,
                                  size: 10,
                                  color: Colors.white,
                                )),
                          )
                      ],
                    ),
                    submissionInProgress
                        ? Transform.scale(
                            scale: 0.5,
                            child: const CenteredCircularProgressIndicator(),
                          )
                        : IconButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                state.isSendButtonDisabled
                                    ? Colors.grey
                                    : const Color(0xFF2B9279),
                              ),
                              shape: WidgetStateProperty.all(
                                const CircleBorder(),
                              ),
                            ),
                            icon: const Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                            onPressed: state.isSendButtonDisabled
                                ? null
                                : cubit.sendMessage,
                          ),
                  ],
                ),
              ),
              if (attachVisible) ...[
                VerticalGap.medium(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (state.files != null) ...[
                      Column(
                        children: [
                          IconButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                Colors.white,
                              ),
                              shape: WidgetStateProperty.all(
                                const CircleBorder(),
                              ),
                            ),
                            icon: const Icon(Icons.cancel_outlined,
                                color: Colors.red),
                            onPressed: submissionInProgress
                                ? null
                                : cubit.deletePickedFile,
                          ),
                          Text(
                            l10n.deleteFileIconLabel,
                          ),
                        ],
                      ),
                      HorizontalGap.medium(),
                    ],
                    Column(
                      children: [
                        IconButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Colors.white,
                            ),
                            shape: WidgetStateProperty.all(
                              const CircleBorder(),
                            ),
                          ),
                          icon: const Icon(Icons.attach_file),
                          onPressed:
                              submissionInProgress ? null : cubit.pickFiles,
                        ),
                        Text(
                          l10n.uploadFileIconLabel,
                        ),
                      ],
                    ),
                    HorizontalGap.medium(),
                    Column(
                      children: [
                        IconButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Colors.white,
                            ),
                            shape: WidgetStateProperty.all(
                              const CircleBorder(),
                            ),
                          ),
                          icon: const Icon(Icons.camera_alt),
                          onPressed: submissionInProgress
                              ? null
                              : cubit.pickImageFromGallery,
                        ),
                        Text(
                          l10n.uploadImageFromGalleryIconLabel,
                        )
                      ],
                    ),
                    HorizontalGap.medium(),
                    Column(
                      children: [
                        IconButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Colors.white,
                            ),
                            shape: WidgetStateProperty.all(
                              const CircleBorder(),
                            ),
                          ),
                          icon: const Icon(Icons.camera_alt),
                          onPressed:
                              submissionInProgress ? null : cubit.capturePhoto,
                        ),
                        Text(
                          l10n.captureImageIconLabel,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
