import 'package:domain_models/domain_models.dart';
import 'package:confirm_dispute/src/l10n/confirm_dispute_localizations.dart';
import 'package:confirm_dispute/src/confirm_dispute_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_repository/service_repository.dart';

class ConfirmDisputeBottomSheet extends StatelessWidget {
  const ConfirmDisputeBottomSheet({
    required this.serviceRepository,
    required this.service,
    super.key,
  });

  final ServiceRepository serviceRepository;
  final Service service;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConfirmDisputeCubit>(
      create: (_) => ConfirmDisputeCubit(
        serviceRepository: serviceRepository,
        service: service,
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
        if (state.disputingStatus == DisputingStatus.success) {
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    onChanged: cubit.updateDisputeMessage,
                    decoration: InputDecoration(
                      labelText: l10n.disputeMessageLabel,
                    ),
                  ),
                  VerticalGap.medium(),
                  state.disputingStatus == DisputingStatus.loading
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
