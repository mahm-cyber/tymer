import 'package:component_library/component_library.dart';
import 'package:dispute_chat/src/l10n/dispute_chat_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_svg/svg.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:dispute_chat/src/dispute_chat_cubit.dart';
import 'package:service_repository/service_repository.dart';

import 'package:user_repository/user_repository.dart';
import 'package:voice_message_package/voice_message_package.dart';

class DisputeChatScreen extends StatelessWidget {
  const DisputeChatScreen({
    required this.userRepository,
    required this.serviceRepository,
    required this.disputeId,
    super.key,
  });

  final UserRepository userRepository;
  final ServiceRepository serviceRepository;
  final int disputeId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DisputeChatCubit>(
      create: (_) => DisputeChatCubit(
        userRepository: userRepository,
        serviceRepository: serviceRepository,
        disputeId: disputeId,
      ),
      child: const DisputeChatView(),
    );
  }
}

class DisputeChatView extends StatelessWidget {
  const DisputeChatView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final l10n = DisputeChatLocalizations.of(context);
    final cubit = context.read<DisputeChatCubit>();
    return BlocBuilder<DisputeChatCubit, DisputeChatState>(
      builder: (context, state) {
        final errorLoading = state.messagesFetchStatus == FetchStatus.failure;
        final loading = state.messagesFetchStatus == FetchStatus.inProgress;
        return GestureDetector(
          onTap: context.releaseFocus,
          child: Scaffold(
            appBar: AppBar(
              title: Text(l10n.appBarTitle),
              backgroundColor: theme.materialThemeData.colorScheme.surface,
            ),
            body: loading
                ? const CenteredCircularProgressIndicator()
                : errorLoading
                    ? ExceptionIndicator(
                        onTryAgain: cubit.init,
                      )
                    : Chat(
                        theme: DefaultChatTheme(
                          primaryColor: theme.primaryColor,
                          inputBackgroundColor: theme.primaryColor,
                          inputTextColor:
                              theme.materialThemeData.colorScheme.onSurface,
                          sendButtonIcon: Icon(
                            Icons.send,
                            color: theme.materialThemeData.colorScheme.surface,
                          ),
                          attachmentButtonIcon: Icon(
                            Icons.attach_file,
                            color: theme.materialThemeData.colorScheme.surface,
                          ),
                          sendingIcon: Transform.scale(
                            scale: 0.65,
                            child: CircularProgressIndicator(
                              color:
                                  theme.materialThemeData.colorScheme.surface,
                            ),
                          ),
                          inputTextDecoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    theme.materialThemeData.colorScheme.surface,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                        messages: state.messages!,
                        imageHeaders: {
                          "Authorization": "Bearer ${state.userToken}",
                          "X-API-Key": const String.fromEnvironment('x_api_key'),
                        },
                        imageMessageBuilder: (
                          types.ImageMessage imageMessage, {
                          required int messageWidth,
                        }) {
                          final isSvg = imageMessage.uri.endsWith('.svg');
                          return isSvg
                              ? SvgPicture.network(
                                  imageMessage.uri,
                                  fit: BoxFit.contain,
                                )
                              : ImageMessage(
                                  message: imageMessage,
                                  messageWidth: messageWidth,
                                  imageHeaders: {
                                    "Authorization":
                                        "Bearer ${state.userToken}",
                                    "X-API-Key":
                                        const String.fromEnvironment('x_api_key'),
                                  },
                                );
                        },
                        audioMessageBuilder: (types.AudioMessage audioMessage,
                            {required int messageWidth}) {
                          final isMine =
                              audioMessage.author.id == state.user!.id;
                          return VoiceMessageView(
                            backgroundColor: isMine
                                ? theme.primaryColor
                                : Colors.grey.withAlpha((255 * 0.2).toInt()),
                            circlesColor:
                                isMine ? theme.primaryColor : Colors.grey,
                            controller: VoiceController(
                              audioSrc: audioMessage.uri,
                              maxDuration: audioMessage.duration,
                              onComplete: () {},
                              onPause: () {},
                              onPlaying: () {},
                              isFile: false,
                            ),
                          );
                        },
                        showUserNames: true,
                        onSendPressed: (message) {},
                        onMessageTap: cubit.handleMessageTap,
                        onAttachmentPressed: () {},
                        user: state.user!,
                      ),
          ),
        );
      },
    );
  }
}
