import 'package:component_library/component_library.dart';
import 'package:support_chat/support_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_chat/src/support_chat_cubit.dart';
import 'package:form_fields/form_fields.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:support_repository/support_repository.dart';
import 'package:user_repository/user_repository.dart';

import 'components/components.dart';

class SupportChatScreen extends StatefulWidget {
  const SupportChatScreen({
    super.key,
    required this.supportRepository,
    required this.userRepository,
  });

  final SupportRepository supportRepository;
  final UserRepository userRepository;

  @override
  State<SupportChatScreen> createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends State<SupportChatScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<SupportChatCubit>(
      create: (_) => SupportChatCubit(
        supportRepository: widget.supportRepository,
        userRepository: widget.userRepository,
      ),
      child: const SupportChatView(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class SupportChatView extends StatelessWidget {
  const SupportChatView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = SupportChatLocalizations.of(context);
    final cubit = context.read<SupportChatCubit>();
    return BlocConsumer<SupportChatCubit, SupportChatState>(
      listenWhen: (previous, current) => previous.files != current.files,
      listener: (context, state) {
        if (state.files.any((file) =>
            file.isNotValid &&
            file.error == FileSizeValidationError.exceedsSizeLimit)) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: (l10n.attachmentSizeExceedsLimitErrorSnackBarMessage),
            ),
          );
        }
      },
      builder: (context, state) {
        final l10n = SupportChatLocalizations.of(context);
        final isCheckingSupportChatExistenceInProgress =
            state.supportChatExistenceCheckFetchStatus ==
                SupportChatExistenceCheckFetchStatus.inProgress;

        final isCheckingSupportChatExistenceFailure =
            state.supportChatExistenceCheckFetchStatus ==
                SupportChatExistenceCheckFetchStatus.failure;

        final hasSupportChat = state.chatId != null;

        return GestureDetector(
          onTap: context.releaseFocus,
          child: SafeArea(
            top: false,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text(l10n.appBarTitle),
              ),
              body: isCheckingSupportChatExistenceInProgress
                  ? const CenteredCircularProgressIndicator()
                  : isCheckingSupportChatExistenceFailure
                      ? ExceptionIndicator(
                          onTryAgain: cubit.checkIfUserHasSupportChat,
                        )
                      : hasSupportChat
                          ? const SupportChat()
                          : const FaqAndStartChat(),
            ),
          ),
        );
      },
    );
  }
}
