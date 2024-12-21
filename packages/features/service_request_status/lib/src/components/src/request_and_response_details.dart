import 'package:domain_models/domain_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_request_status/src/l10n/service_request_status_localizations.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:service_request_status/src/service_request_status_cubit.dart';

class RequestAndResponseDetails extends StatelessWidget {
  const RequestAndResponseDetails({
    super.key,
    this.service,
  });

  final Service? service;

  @override
  Widget build(BuildContext context) {
    final colorScheme = TymerTheme.of(context).materialThemeData.colorScheme;
    final l10n = ServiceRequestStatusLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final cubit = context.read<ServiceRequestStatusCubit>();

    return BlocBuilder<ServiceRequestStatusCubit, ServiceRequestStatusState>(
      builder: (context, state) {
        final isCancelled = state.service?.status == ServiceStatus.canceled;
        final isConfirmationInProgress =
            state.confirmationStatus == ConfirmationStatus.loading;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  VerticalGap.xLarge(),
                  VerticalGap.mediumLarge(),
                  if (state.service?.requestDetails != null) ...[
                    ServiceRequestDetailsExpansionTile(
                      service: state.service!,
                      onViewServiceOnMap: cubit.onViewServiceOnMap,
                    ),
                    VerticalGap.medium(),
                  ],
                  if (state.service?.responseDetails != null) ...[
                    ServiceResponseDetailsExpansionTile(
                      service: state.service!,
                      userToken: state.userToken!,
                    ),
                    VerticalGap.medium(),
                  ],
                ],
              ),
            ),
            if (!isCancelled) ...[
              VerticalGap.medium(),
              Container(
                padding: const EdgeInsets.all(Spacing.medium),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(),
                ),
                child: Column(
                  children: [
                    Text(
                      l10n.requestDoneContainerTitle,
                      style: textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    VerticalGap.medium(),
                    Row(
                      children: [
                        VerticalGap.medium(),
                        isConfirmationInProgress
                            ? Expanded(
                                child: TymerElevatedButton.inProgress(
                                  label: l10n.yesButtonLabel,
                                ),
                              )
                            : Expanded(
                                child: TymerElevatedButton(
                                  label: l10n.yesButtonLabel,
                                  onTap: cubit.confirmService,
                                ),
                              ),
                        HorizontalGap.medium(),
                        Expanded(
                          child: TymerElevatedButton(
                            label: l10n.noButtonLabel,
                            onTap: isConfirmationInProgress
                                ? null
                                : () => cubit.onConfirmDisputeTapped(service!),
                            bgColor: colorScheme.error,
                          ),
                        ),
                      ].reversed.toList(),
                    ),
                  ],
                ),
              ),
            ],
            if (isCancelled) ...[
              VerticalGap.medium(),
              TymerElevatedButton(
                label: l10n.backHomeButtonLabel,
                onTap: cubit.goBackHome,
              ),
              VerticalGap.medium(),
            ]
          ],
        );
      },
    );
  }
}
