import 'package:chat/src/l10n/chat_localizations.dart';
import 'package:component_library/component_library.dart';
import 'package:dispute_repository/dispute_repository.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat/src/chat_cubit.dart';
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
    // final isTablet = !View.of(context).isSmallTabletOrLess;
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        final l10n = ChatLocalizations.of(context);
        final clL10n = ComponentLibraryLocalizations.of(context);
        final disputeStatus = state.dispute?.status;
        final isDisputeChargedBack = disputeStatus == DisputeStatus.chargedBack;
        final idDisputeDenied = disputeStatus == DisputeStatus.denied;
        final isResolved = isDisputeChargedBack || idDisputeDenied;
        return GestureDetector(
          onTap: context.releaseFocus,
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
                            color: state.dispute!.status.color,
                            label: disputeStatusToLocalizedString(
                              state.dispute!.status,
                              clL10n,
                            ),
                          ),
                        ),
                      )
                    : const SendMessage(),
              ],
            ),
          ),
        );
      },
    );
  }
}
