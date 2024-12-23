import 'package:chat/src/l10n/chat_localizations.dart';
import 'package:component_library/component_library.dart';
import 'package:dispute_repository/dispute_repository.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat/src/chat_cubit.dart';
import 'package:form_fields/form_fields.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:user_repository/user_repository.dart';

import 'components/components.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.disputeRepository,
    required this.userRepository,
    required this.disputeId,
  });

  final DisputeRepository disputeRepository;
  final UserRepository userRepository;
  final int disputeId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<ChatCubit>(
      create: (_) => ChatCubit(
        disputeRepository: widget.disputeRepository,
        userRepository: widget.userRepository,
        disputeId: widget.disputeId,
      ),
      child: const ChatView(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ChatView extends StatelessWidget {
  const ChatView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = ChatLocalizations.of(context);
    final cubit = context.read<ChatCubit>();
    final userType = cubit.getCurrentChatUserType();
    final isRequesterChat = userType == UserType.requester;
    final isProviderChat = userType == UserType.provider;
    return BlocConsumer<ChatCubit, ChatState>(
      listenWhen: (previous, current) =>
          previous.dispute?.status != current.dispute?.status ||
          previous.files != current.files,
      listener: (context, state) {
        final isRequesterRefunded =
            state.dispute?.status == DisputeStatus.refunded;
        final isDisputeRejected = state.dispute?.status == DisputeStatus.denied;
        if (isRequesterChat && isRequesterRefunded) {
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              context: context,
              message: (l10n.refundedRequesterSnackBarMessage),
            ),
          );
        }
        if (isRequesterChat && isDisputeRejected) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: (l10n.deniedRequesterSnackBarMessage),
            ),
          );
        }
        if (isProviderChat && isRequesterRefunded) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: (l10n.providerLostDisputeSnackBarMessage),
            ),
          );
        }
        if (isProviderChat && isDisputeRejected) {
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              context: context,
              message: (l10n.providerWonDisputeSnackBarMessage),
            ),
          );
        }
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
        final l10n = ChatLocalizations.of(context);
        final clL10n = ComponentLibraryLocalizations.of(context);
        final disputeStatus = state.dispute?.status;
        final isRequesterRefunded = disputeStatus == DisputeStatus.refunded;
        final idDisputeDenied = disputeStatus == DisputeStatus.denied;
        final isResolved = isRequesterRefunded || idDisputeDenied;

        final resolution = getDisputeResolutionDetails(
          isRequesterRefunded,
          idDisputeDenied,
          isRequesterChat,
          isProviderChat,
          clL10n,
        );

        return GestureDetector(
          onTap: context.releaseFocus,
          child: SafeArea(
            top: false,
            child: Scaffold(
              appBar: AppBar(
                // centerTitle: false,
                backgroundColor: Colors.white,
                title: Text(l10n.appBarTitle),
              ),
              body: Column(
                children: [
                  const MessagesList(),
                  isResolved
                      ? Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          color: Colors.grey.withAlpha(50),
                          child: Center(
                            child: ServiceStatusWidget(
                              color: resolution.color,
                              label: resolution.label,
                            ),
                          ),
                        )
                      : const SendMessage(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
