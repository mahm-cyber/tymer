import 'package:component_library/component_library.dart';
import 'package:dispute_chat/dispute_chat.dart';
import 'package:dispute_repository/dispute_repository.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dispute_chat/src/dispute_chat_cubit.dart';
import 'package:form_fields/form_fields.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:user_repository/user_repository.dart';

class DisputeChatScreen extends StatefulWidget {
  const DisputeChatScreen({
    super.key,
    required this.disputeRepository,
    required this.userRepository,
    required this.disputeId,
  });

  final DisputeRepository disputeRepository;
  final UserRepository userRepository;
  final int disputeId;

  @override
  State<DisputeChatScreen> createState() => _DisputeChatScreenState();
}

class _DisputeChatScreenState extends State<DisputeChatScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<DisputeChatCubit>(
      create: (_) => DisputeChatCubit(
        disputeRepository: widget.disputeRepository,
        userRepository: widget.userRepository,
        disputeId: widget.disputeId,
      ),
      child: const DisputeChatView(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class DisputeChatView extends StatelessWidget {
  const DisputeChatView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = DisputeChatLocalizations.of(context);
    final clL10n = ComponentLibraryLocalizations.of(context);
    final cubit = context.read<DisputeChatCubit>();
    final userType = cubit.getCurrentDisputeChatUserType();
    final isRequesterDisputeChat = userType == UserType.requester;
    final isProviderDisputeChat = userType == UserType.provider;
    return BlocConsumer<DisputeChatCubit, DisputeChatState>(
      listenWhen: (previous, current) =>
          previous.dispute?.status != current.dispute?.status ||
          previous.files != current.files ||
          previous.error != current.error,
      listener: (context, state) {
        if (state.error is ChatLimitReachedException) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: (clL10n.chatLimitReachedErrorMessage),
            ),
          );
        }
        final isRequesterRefunded =
            state.dispute?.status == DisputeStatus.refunded;
        final isDisputeRejected = state.dispute?.status == DisputeStatus.denied;
        if (isRequesterDisputeChat && isRequesterRefunded) {
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              context: context,
              message: (l10n.refundedRequesterSnackBarMessage),
            ),
          );
        }
        if (isRequesterDisputeChat && isDisputeRejected) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: (l10n.deniedRequesterSnackBarMessage),
            ),
          );
        }
        if (isProviderDisputeChat && isRequesterRefunded) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: (l10n.providerLostDisputeSnackBarMessage),
            ),
          );
        }
        if (isProviderDisputeChat && isDisputeRejected) {
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
        final l10n = DisputeChatLocalizations.of(context);
        final clL10n = ComponentLibraryLocalizations.of(context);
        final disputeStatus = state.dispute?.status;
        final isRequesterRefunded = disputeStatus == DisputeStatus.refunded;
        final idDisputeDenied = disputeStatus == DisputeStatus.denied;
        final isResolved = isRequesterRefunded || idDisputeDenied;

        final resolution = getDisputeResolutionDetails(
          isRequesterRefunded,
          idDisputeDenied,
          isRequesterDisputeChat,
          isProviderDisputeChat,
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
                  MessagesList(
                    userToken: state.userToken ?? '',
                    dateGroupedMessages: state.dateGroupedMessages?.list ?? [],
                    submissionInProgress: state.submissionStatus ==
                        DisputeChatSubmissionStatus.inProgress,
                    sendMessage: cubit.sendMessage,
                    onMessageChanged: cubit.onMessageChanged,
                    loading: state.disputeChatFetchingStatus ==
                            DisputeChatFetchingStatus.inProgress ||
                        state.dateGroupedMessages == null,
                    error: state.disputeChatFetchingStatus ==
                        DisputeChatFetchingStatus.failure,
                    scrollController: cubit.scrollController,
                  ),
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
                      : SendMessage(
                          messageController: cubit.messageController,
                          submissionInProgress: state.submissionStatus ==
                              DisputeChatSubmissionStatus.inProgress,
                          files: state
                              .files, // Assuming state.files is the list of files
                          isSendButtonDisabled: state.isSendButtonDisabled,
                          onSendMessage: cubit.sendMessage,
                          onMessageChanged: cubit.onMessageChanged,
                          onDeletePickedFile: cubit.deletePickedFile,
                          onPickFile: cubit.pickFile,
                          onPickImageFromGallery: cubit.pickImageFromGallery,
                          onCapturePhoto: cubit.capturePhoto,
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
