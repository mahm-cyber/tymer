import 'package:domain_models/domain_models.dart';
import 'package:service_request_status/src/l10n/service_request_status_localizations.dart';
import 'package:service_request_status/src/service_request_status_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_repository/service_repository.dart';

import 'package:user_repository/user_repository.dart';

import 'components/components.dart';

class ServiceRequestStatusScreen extends StatelessWidget {
  const ServiceRequestStatusScreen({
    required this.userRepository,
    required this.serviceRepository,
    required this.goBackHome,
    required this.requestId,
    required this.onConfirmDisputeTapped,
    super.key,
  });

  final UserRepository userRepository;
  final ServiceRepository serviceRepository;
  final VoidCallback goBackHome;
  final int requestId;
  final ValueSetter<Service> onConfirmDisputeTapped;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceRequestStatusCubit>(
      create: (_) => ServiceRequestStatusCubit(
        userRepository: userRepository,
        serviceRepository: serviceRepository,
        goBackHome: goBackHome,
        requestId: requestId,
        onConfirmDisputeTapped: onConfirmDisputeTapped,
      ),
      child: const ServiceRequestStatusView(),
    );
  }
}

class ServiceRequestStatusView extends StatelessWidget {
  const ServiceRequestStatusView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final colorScheme = theme.materialThemeData.colorScheme;
    final l10n = ServiceRequestStatusLocalizations.of(context);
    return BlocConsumer<ServiceRequestStatusCubit, ServiceRequestStatusState>(
      listenWhen: (previous, current) =>
          previous.cancellationStatus != current.cancellationStatus ||
          previous.confirmationStatus != current.confirmationStatus,
      listener: (context, state) {
        if (state.cancellationStatus == CancellationStatus.success) {
          // cubit.goBackHome();
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              message: l10n.cancellationSuccessMessage,
              context: context,
              marginalSpace: theme.snackBarMargin,
            ),
          );
        }
        if (state.cancellationStatus == CancellationStatus.error) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              message: l10n.cancellationErrorMessage,
              context: context,
            ),
          );
        }
        if (state.confirmationStatus == ConfirmationStatus.success) {
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              message: l10n.confirmationSuccessMessage,
              context: context,
              marginalSpace: theme.snackBarMargin,
            ),
          );
        }
        if (state.confirmationStatus == ConfirmationStatus.error) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              message: l10n.confirmationErrorMessage,
              context: context,
            ),
          );
        }
      },
      builder: (context, state) {
        final isPendingReview =
            state.service?.status == ServiceStatus.pendingReview;
        final isPending = state.service?.status == ServiceStatus.pending;
        final isCancelled = state.service?.status == ServiceStatus.canceled;
        final isRequestConfirmed =
            state.service?.status == ServiceStatus.completed ||
                state.confirmationStatus == ConfirmationStatus.success;
        final isInitialFetchSomeProgress =
            state.fetchStatus == FetchStatus.loading;
        final errorFetching = state.fetchStatus == FetchStatus.error;
        final cubit = context.read<ServiceRequestStatusCubit>();
        final clL10n = ComponentLibraryLocalizations.of(context);
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: const SvgAsset(AssetPathConstants.whiteLogoPath),
                toolbarHeight: 160,
                iconTheme: IconThemeData(color: colorScheme.surface),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: theme.screenMargin,
                ),
                child: isInitialFetchSomeProgress
                    ? const CenteredCircularProgressIndicator()
                    : errorFetching
                        ? ExceptionIndicator(
                            onTryAgain: cubit.init,
                          )
                        : isRequestConfirmed
                            ? Column(
                                children: [
                                  VerticalGap.xLarge(),
                                  VerticalGap.medium(),
                                  Receipt(
                                    service: state.service!,
                                    onViewServiceOnMap:
                                        cubit.onViewServiceOnMap,
                                    userToken: state.userToken,
                                  ),
                                  TymerElevatedButton(
                                    label: l10n.backHomeButtonLabel,
                                    onTap: cubit.goBackHome,
                                  ),
                                  VerticalGap.medium(),
                                ],
                              )
                            : isPendingReview || isCancelled
                                ? RequestAndResponseDetails(
                                    service: state.service,
                                  )
                                : Column(
                                    children: [
                                      Expanded(
                                        child: ListView(
                                          children: [
                                            VerticalGap.xLarge(),
                                            VerticalGap.medium(),
                                            if (state.service?.requestDetails !=
                                                null)
                                              ServiceRequestDetailsExpansionTile(
                                                service: state.service!,
                                                onViewServiceOnMap:
                                                    cubit.onViewServiceOnMap,
                                              ),
                                            VerticalGap.medium(),
                                            RequestStatusStep(
                                              title:
                                                  l10n.findingSomeoneStepTitle,
                                              status: state.service?.status ==
                                                      null
                                                  ? RequestStatus.idle
                                                  : state.service?.status ==
                                                          ServiceStatus.pending
                                                      ? RequestStatus.loading
                                                      : RequestStatus.done,
                                            ),
                                            VerticalGap.medium(),
                                            RequestStatusStep(
                                              title: l10n.processingStepTitle,
                                              status: state.service?.status ==
                                                      ServiceStatus.inProgress
                                                  ? RequestStatus.loading
                                                  : state.service?.status ==
                                                          ServiceStatus
                                                              .pendingReview
                                                      ? RequestStatus.done
                                                      : RequestStatus.idle,
                                            ),
                                            VerticalGap.medium(),
                                            RequestStatusStep(
                                              title: l10n.completeStepTitle,
                                              status: state.service?.status ==
                                                          ServiceStatus
                                                              .completed ||
                                                      state.service?.status ==
                                                          ServiceStatus
                                                              .pendingReview
                                                  ? RequestStatus.done
                                                  : RequestStatus.idle,
                                            ),
                                            VerticalGap.medium(),
                                          ],
                                        ),
                                      ),
                                      if (isPending) ...[
                                        state.cancellationStatus ==
                                                CancellationStatus.loading
                                            ? TymerElevatedButton.inProgress(
                                                label: l10n.cancelButtonLabel,
                                              )
                                            : TymerElevatedButton(
                                                label: l10n.cancelButtonLabel,
                                                bgColor: colorScheme.error,
                                                onTap: () => context
                                                    .read<
                                                        ServiceRequestStatusCubit>()
                                                    .cancelService(),
                                              ),
                                        VerticalGap.medium(),
                                      ],
                                    ],
                                  ),
              ),
            ),
            AppBarTitleContainer(
              widgetTitle: state.service != null
                  ? ServiceStatusWidget(
                      color: state.service?.status?.color ?? Colors.black,
                      label: serviceRequestStatusToLocalizedString(
                        state.service!.status!,
                        clL10n,
                      ),
                      border: const Border(),
                    )
                  : null,
              title: '',
            ),
          ],
        );
      },
    );
  }
}
