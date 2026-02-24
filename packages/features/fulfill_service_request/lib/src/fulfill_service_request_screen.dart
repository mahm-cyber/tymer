import 'package:dispute_repository/dispute_repository.dart';
import 'package:domain_models/domain_models.dart';
import 'package:form_fields/form_fields.dart';
import 'package:fulfill_service_request/fulfill_service_request.dart';
import 'package:fulfill_service_request/src/fulfill_service_request_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:service_repository/service_repository.dart';
import 'package:user_repository/user_repository.dart';

import 'components/components.dart';

class FulfillServiceRequestScreen extends StatelessWidget {
  const FulfillServiceRequestScreen({
    required this.requestId,
    required this.disputeRepository,
    required this.serviceRepository,
    required this.userRepository,
    required this.onNavigateToProvideService,
    required this.onServiceDisputed,
    required this.onBackButtonPressed,
    super.key,
  });

  final int requestId;
  final DisputeRepository disputeRepository;
  final ServiceRepository serviceRepository;
  final UserRepository userRepository;
  final VoidCallback onNavigateToProvideService;
  final ValueSetter<int> onServiceDisputed;
  final VoidCallback onBackButtonPressed;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FulfillServiceRequestCubit>(
      create: (_) => FulfillServiceRequestCubit(
        requestId: requestId,
        disputeRepository: disputeRepository,
        serviceRepository: serviceRepository,
        userRepository: userRepository,
        onNavigateToProvideService: onNavigateToProvideService,
        onServiceDisputed: onServiceDisputed,
        onBackButtonPressed: onBackButtonPressed,
      ),
      child: GestureDetector(
        onTap: context.releaseFocus,
        child: const FulfillServiceRequestView(),
      ),
    );
  }
}

class FulfillServiceRequestView extends StatelessWidget {
  const FulfillServiceRequestView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final colorScheme = theme.materialThemeData.colorScheme;
    final l10n = FulfillServiceRequestLocalizations.of(context);
    final clL10n = ComponentLibraryLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    return BlocConsumer<FulfillServiceRequestCubit, FulfillServiceRequestState>(
      listenWhen: (previous, current) =>
          previous.isImagePickerBottomSheetVisible !=
              current.isImagePickerBottomSheetVisible ||
          previous.submissionStatus != current.submissionStatus ||
          previous.cancelStatus != current.cancelStatus ||
          previous.service?.status != current.service?.status,
      listener: (context, state) {
        final cubit = context.read<FulfillServiceRequestCubit>();
        if (state.service?.status == ServiceStatus.disputed) {
          cubit.onServiceRequestDisputed();
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: l10n.serviceDisputedSnackBarMessage,
              marginalSpace: theme.snackBarMargin,
            ),
          );
          return;
        }

        if (state.isImagePickerBottomSheetVisible == true) {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.vertical(
                top: Radius.circular(20),
              ),
            ),
            context: context,
            builder: (context) {
              return BackButtonListener(
                onBackButtonPressed: () async {
                  cubit.onBackButtonPressed();
                  return true;
                },
                child: ImagePickerBottomSheet(
                  galleryIcon: Icons.collections,
                  cameraIcon: Icons.camera_alt,
                  galleryText: clL10n.bottomSheetGalleryButton,
                  cameraText: clL10n.bottomSheetCaptureButton,
                  onTapGallery: () {
                    Navigator.pop(context);
                    cubit.pickImageFromGallery();
                  },
                  onTapCamera: () {
                    Navigator.pop(context);
                    cubit.capturePhoto();
                  },
                ),
              );
            },
          ).whenComplete(() {
            cubit.onImagePickerBottomSheetClosed();
          });
        }
        if (state.submissionStatus == FormzSubmissionStatus.success) {
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              context: context,
              message: l10n.serviceRequestSuccessMessage,
              marginalSpace: theme.snackBarMargin,
            ),
          );
        }
        if (state.submissionStatus == FormzSubmissionStatus.failure) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: l10n.serviceRequestFailureMessage,
              marginalSpace: theme.snackBarMargin,
            ),
          );
        }
        if (state.cancelStatus == FormzSubmissionStatus.failure) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: l10n.cancelFailureSnackBarMessage,
              marginalSpace: theme.snackBarMargin,
            ),
          );
        }
        if (state.submissionStatus == FormzSubmissionStatus.inProgress &&
            state.service?.status == ServiceStatus.pendingReview) {
          //dialog asking if they want to provide another service or wait for confirmation
          showDialog(
              useRootNavigator: false,
              context: context,
              builder: (context) {
                return BackButtonListener(
                  onBackButtonPressed: () async {
                    cubit.onBackButtonPressed();
                    return true;
                  },
                  child: AlertDialog(
                    title: Text(
                      l10n.awaitingConfirmationButtonLabel,
                      style: textTheme.titleLarge,
                    ),
                    // actionsAlignment: MainAxisAlignment.center,
                    actions: [
                      TymerElevatedButton(
                        onTap: cubit.onNavigateToProvideService,
                        label: (l10n.provideAnotherServiceButtonLabel),
                      ),
                      VerticalGap.medium(),
                      TymerElevatedButton(
                        bgColor: colorScheme.surface,
                        borderColor: theme.borderColor,
                        labelColor: colorScheme.onSurface,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        label: (l10n.continueWaitingButtonLabel),
                      ),
                    ],
                  ),
                );
              });
        }
      },
      builder: (context, state) {
        final cubit = context.read<FulfillServiceRequestCubit>();
        final isRequestFulfilled =
            state.submissionStatus == FormzSubmissionStatus.success ||
                state.service?.status == ServiceStatus.completed;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final fetchServiceError = state.fetchStatus == FetchStatus.failure;
        final isInitialFetchInProgress =
            state.fetchStatus == FetchStatus.loading;
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: const SvgAsset(
                  AssetPathConstants.whiteLogoPath,
                  height: 30,
                ),
                toolbarHeight: 70,
                iconTheme: IconThemeData(color: colorScheme.surface),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: theme.screenMargin,
                ),
                child: isInitialFetchInProgress
                    ? const CenteredCircularProgressIndicator()
                    : fetchServiceError
                        ? ExceptionIndicator(
                            onTryAgain: cubit.init,
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              VerticalGap.xLarge(),
                              if (!isRequestFulfilled)
                                Expanded(
                                  child: ListView(
                                    children: [
                                      ServiceRequestDetailsExpansionTile(
                                        service: state.service!,
                                        onViewServiceOnMap:
                                            cubit.onViewServiceOnMap,
                                      ),
                                      VerticalGap.small(),
                                      if (state.service?.type ==
                                          ServiceType.reservation) ...[
                                        const ReservationNumberTextField(),
                                        VerticalGap.small(),
                                      ],
                                      DayPicker(
                                        onChanged: cubit.onDayChanged,
                                        error: state.day.error,
                                        isSubmissionInProgress:
                                            isSubmissionInProgress,
                                        initialValue: state
                                            .service?.responseDetails?.date,
                                      ),
                                      VerticalGap.small(),
                                      TimePicker(
                                        onChanged: cubit.onTimeChanged,
                                        error: state.time.error,
                                        isSubmissionInProgress:
                                            isSubmissionInProgress,
                                        initialValue: state
                                            .service?.responseDetails?.time,
                                        onBackButtonPressed:
                                            cubit.onBackButtonPressed,
                                      ),
                                      VerticalGap.small(),
                                      ImagePickerTextField(
                                        imageFileNameSC: cubit.imageFileNameSC,
                                        onImagePickerTapped:
                                            cubit.onImagePickerTapped,
                                        deletePickedImage:
                                            cubit.deletePickedImage,
                                        onBackButtonPressed:
                                            cubit.onBackButtonPressed,
                                        isSubmissionInProgress:
                                            isSubmissionInProgress,
                                        imageUrl: state
                                            .service?.responseDetails?.imageUrl,
                                        imageError: state.file.isNotValid
                                            ? state.file.error
                                            : null,
                                        hasPickedImage:
                                            state.file.value != null &&
                                                state.file.isValid,
                                        userToken: state.userToken!,
                                        imageBytes:
                                            state.file.value?.readAsBytesSync(),
                                        isStatusPendingReview:
                                            state.service?.status ==
                                                ServiceStatus.pendingReview,
                                        isImagePicked: state.file.value != null,
                                      ),
                                      VerticalGap.small(),
                                      const AdditionalDetailsTextField(),
                                      VerticalGap.small(),
                                    ],
                                  ),
                                ),
                              if (isRequestFulfilled)
                                Receipt(
                                  service: state.service!,
                                  onViewServiceOnMap: cubit.onViewServiceOnMap,
                                  userToken: state.userToken,
                                ),
                              VerticalGap.medium(),
                              if (!isRequestFulfilled)
                                isSubmissionInProgress
                                    ? TymerElevatedButton.inProgress(
                                        label: l10n
                                            .awaitingConfirmationButtonLabel,
                                      )
                                    : TymerElevatedButton(
                                        label: l10n.submitButtonLabel,
                                        onTap: cubit.onSubmit,
                                      ),
                              VerticalGap.medium(),
                              if (!isRequestFulfilled)
                                state.cancelStatus ==
                                        FormzSubmissionStatus.inProgress
                                    ? TymerElevatedButton.inProgress(
                                        label: l10n.cancelButtonLabel,
                                      )
                                    : TymerElevatedButton(
                                        label: l10n.cancelButtonLabel,
                                        bgColor: colorScheme.surface,
                                        borderColor: theme.borderColor,
                                        labelColor: colorScheme.onSurface,
                                        onTap: cubit.onCancelRequest,
                                      ),
                              VerticalGap.medium(),
                              VerticalGap.small(),
                            ],
                          ),
              ),
            ),
            AppBarTitleContainer(
              top: theme.smallAppBarTitleContainerHeight,
              height: 30,
              widgetTitle: state.service != null
                  ? ServiceStatusWidget(
                      width: 160,
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
