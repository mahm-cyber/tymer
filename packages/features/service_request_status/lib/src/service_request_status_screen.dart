import 'package:domain_models/domain_models.dart';
import 'package:service_request_status/src/l10n/service_request_status_localizations.dart';
import 'package:service_request_status/src/service_request_status_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:service_repository/service_repository.dart';

import 'package:user_repository/user_repository.dart';

import 'components/components.dart';

class ServiceRequestStatusScreen extends StatelessWidget {
  const ServiceRequestStatusScreen({
    required this.userRepository,
    required this.serviceRepository,
    required this.onCancellationSuccess,
    required this.requestId,
    super.key,
  });

  final UserRepository userRepository;
  final ServiceRepository serviceRepository;
  final VoidCallback onCancellationSuccess;
  final int requestId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceRequestStatusCubit>(
      create: (_) => ServiceRequestStatusCubit(
        userRepository: userRepository,
        serviceRepository: serviceRepository,
        onCancellationSuccess: onCancellationSuccess,
        requestId: requestId,
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
      listener: (context, state) {
        final cubit = context.read<ServiceRequestStatusCubit>();
        if (state.cancellationStatus == CancellationStatus.success) {
          cubit.onCancellationSuccess();
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              message: l10n.cancellationSuccessMessage,
              context: context,
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
        if(state.confirmationStatus == ConfirmationStatus.success) {
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              message: l10n.confirmationSuccessMessage,
              context: context,
            ),
          );
        }
        if(state.confirmationStatus == ConfirmationStatus.error) {
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
        final isRequestCompleted = state.service?.response != null;
        return GestureDetector(
          onTap: context.releaseFocus,
          child: Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  title: const SvgAsset(AssetPathConstants.whiteLogoPath),
                  toolbarHeight: 160,
                  iconTheme: IconThemeData(color: colorScheme.surface),
                ),
                body: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: theme.screenMargin * 2,
                  ),
                  child: isRequestCompleted
                      ? ServiceResponseWidget(
                          response: state.service?.response,
                        )
                      : Column(
                          children: [
                            const Spacer(),
                            RequestStatusStep(
                              title: l10n.findingSomeoneStepTitle,
                              status: state.service?.status == null
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
                                          ServiceStatus.pendingReview
                                      ? RequestStatus.done
                                      : RequestStatus.idle,
                            ),
                            VerticalGap.medium(),
                            RequestStatusStep(
                              title: l10n.completeStepTitle,
                              status: state.service?.status ==
                                          ServiceStatus.completed ||
                                      state.service?.status ==
                                          ServiceStatus.pendingReview
                                  ? RequestStatus.done
                                  : RequestStatus.idle,
                            ),
                            const Spacer(),
                            if (state.service?.status ==
                                ServiceStatus.pending) ...[
                              state.cancellationStatus ==
                                      CancellationStatus.loading
                                  ? TymerElevatedButton.inProgress(
                                      label: l10n.cancelButtonLabel,
                                    )
                                  : TymerElevatedButton(
                                      label: l10n.cancelButtonLabel,
                                      bgColor: colorScheme.error,
                                      onTap: () => context
                                          .read<ServiceRequestStatusCubit>()
                                          .cancelService(),
                                    ),
                              VerticalGap.medium(),
                            ]
                          ],
                        ),
                ),
              ),
              AppBarTitleContainer(
                title: l10n.appBarTitle,
                icon: const SvgAsset(
                  AssetPathConstants.potPath,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
