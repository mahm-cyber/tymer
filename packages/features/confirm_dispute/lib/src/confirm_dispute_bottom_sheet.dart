import 'package:dispute_repository/dispute_repository.dart';
import 'package:domain_models/domain_models.dart';
import 'package:confirm_dispute/src/l10n/confirm_dispute_localizations.dart';
import 'package:confirm_dispute/src/confirm_dispute_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmDisputeBottomSheet extends StatelessWidget {
  const ConfirmDisputeBottomSheet({
    required this.disputeRepository,
    required this.service,
    required this.onDisputeSuccess,
    super.key,
  });

  final DisputeRepository disputeRepository;
  final Service service;
  final ValueSetter<int> onDisputeSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConfirmDisputeCubit>(
      create: (_) => ConfirmDisputeCubit(
        disputeRepository: disputeRepository,
        service: service,
        onDisputeSuccess: onDisputeSuccess,
      ),
      child: const ConfirmDisputeView(),
    );
  }
}

class ConfirmDisputeView extends StatelessWidget {
  const ConfirmDisputeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final colorScheme = theme.materialThemeData.colorScheme;
    final l10n = ConfirmDisputeLocalizations.of(context);
    return BlocConsumer<ConfirmDisputeCubit, ConfirmDisputeState>(
      listener: (context, state) {
        final cubit = context.read<ConfirmDisputeCubit>();
        if (state.disputingStatus == DisputingStatus.success) {
          cubit.onDisputeSuccess(state.disputeId!);
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              message: l10n.disputeSuccessMessage,
              context: context,
            ),
          );
        }
        if (state.disputingStatus == DisputingStatus.error) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              message: l10n.disputeErrorMessage,
              context: context,
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<ConfirmDisputeCubit>();
        final isSubmissionInProgress =
            state.disputingStatus == DisputingStatus.loading;
        return BottomSheet(
          onClosing: () {},
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(Spacing.medium),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.cancel_outlined),
                        onPressed: isSubmissionInProgress
                            ? null
                            : () {
                                Navigator.of(context).pop();
                              },
                      ),

                    ],
                  ),
                  TextField(
                    enabled: !isSubmissionInProgress,
                    onChanged: cubit.updateDisputeMessage,
                    decoration: InputDecoration(
                      labelText: l10n.disputeMessageLabel,
                    ),
                  ),
                  VerticalGap.medium(),
                  isSubmissionInProgress
                      ? TymerElevatedButton.inProgress(
                          label: l10n.disputeButtonLabel)
                      : TymerElevatedButton(
                          onTap: state.reason?.isNotEmpty == true
                              ? cubit.disputeService
                              : null,
                          label: (l10n.disputeButtonLabel),
                        ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
