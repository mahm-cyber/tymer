import 'package:domain_models/domain_models.dart';
import 'package:form_fields/form_fields.dart';
import 'package:fulfill_service_request/fulfill_service_request.dart';
import 'package:fulfill_service_request/src/fulfill_service_request_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:service_repository/service_repository.dart';

import 'components/components.dart';

class FulfillServiceRequestScreen extends StatelessWidget {
  const FulfillServiceRequestScreen({
    required this.serviceRepository,
    super.key,
  });

  final ServiceRepository serviceRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FulfillServiceRequestCubit>(
      create: (_) => FulfillServiceRequestCubit(
        serviceRepository: serviceRepository,
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
    return BlocConsumer<FulfillServiceRequestCubit, FulfillServiceRequestState>(
      listener: (context, state) {
        final cubit = context.read<FulfillServiceRequestCubit>();
        if (state.isImagePickerBottomSheetVisible == true) {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.vertical(
                top: Radius.circular(20),
              ),
            ),
            context: context,
            builder: (context) {
              return ImagePickerBottomSheet(
                galleryIcon: Icons.collections,
                cameraIcon: Icons.camera_alt,
                galleryText: l10n.bottomSheetGalleryButton,
                cameraText: l10n.bottomSheetCaptureButton,
                onTapGallery: () {
                  Navigator.pop(context);
                  cubit.pickImageFromGallery();
                },
                onTapCamera: () {
                  Navigator.pop(context);
                  cubit.capturePhoto();
                },
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
      },
      builder: (context, state) {
        final textTheme = Theme.of(context).textTheme;
        final cubit = context.read<FulfillServiceRequestCubit>();
        final isRequestFulfilled =
            state.submissionStatus == FormzSubmissionStatus.success;
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: const SvgAsset(AssetPathConstants.whiteLogoPath),
                toolbarHeight: 70,
                iconTheme: IconThemeData(color: colorScheme.surface),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: theme.screenMargin,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    VerticalGap.large(),
                    VerticalGap.medium(),
                    // ExpansionTile(
                    //   title: Text(
                    //     l10n.serviceDetailsTitle,
                    //     style: textTheme.titleMedium,
                    //   ),
                    //   collapsedShape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(10),
                    //     side: BorderSide(
                    //       color: colorScheme.secondary,
                    //     ),
                    //   ),
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(10),
                    //     side: BorderSide(
                    //       color: colorScheme.secondary,
                    //     ),
                    //   ),
                    //   children: [
                    //     ServiceDetailsWidget(
                    //       service: state.service!,
                    //       onViewServiceOnMap: cubit.onViewServiceOnMap,
                    //     ),
                    //     VerticalGap.medium(),
                    //   ],
                    // ),
                    if (!isRequestFulfilled)
                      Expanded(
                        child: ListView(
                          children: [
                            ExpansionTile(
                              title: Text(
                                l10n.serviceDetailsTitle,
                                style: textTheme.titleMedium,
                              ),
                              collapsedShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: colorScheme.secondary,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: colorScheme.secondary,
                                ),
                              ),
                              children: [
                                ServiceDetailsWidget(
                                  service: state.service!,
                                  onViewServiceOnMap: cubit.onViewServiceOnMap,
                                ),
                                VerticalGap.medium(),
                              ],
                            ),
                            if (state.service?.type ==
                                ServiceType.reservation) ...[
                              VerticalGap.medium(),
                              const ReservationNumberTextField(),
                            ],
                            VerticalGap.medium(),
                            DayPicker(
                              onChanged: cubit.onDayChanged,
                              error: state.day.error,
                            ),
                            VerticalGap.medium(),
                            TimePicker(
                              onChanged: cubit.onTimeChanged,
                              error: state.time.error,
                            ),
                            VerticalGap.medium(),
                            const ImagePickerTextField(),
                            VerticalGap.medium(),
                            const AdditionalDetailsTextField(),
                          ],
                        ),
                      ),
                    if (isRequestFulfilled)
                      Receipt(
                        service: state.service!,
                        onViewServiceOnMap: cubit.onViewServiceOnMap,
                      ),
                    VerticalGap.medium(),
                    if (!isRequestFulfilled)
                      state.submissionStatus == FormzSubmissionStatus.inProgress
                          ? TymerElevatedButton.inProgress(
                              label: l10n.awaitingConfirmationButtonLabel,
                            )
                          : TymerElevatedButton(
                              label: l10n.submitButtonLabel,
                              onTap: cubit.onSubmit,
                            ),
                    VerticalGap.medium(),
                    if (isRequestFulfilled)
                      TymerElevatedButton(
                        label: l10n.backHomeButtonLabel,
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    VerticalGap.small(),
                  ],
                ),
              ),
            ),
            AppBarTitleContainer(
              top: theme.smallAppBarTitleContainerHeight,
              height: 30,
              title: state.service!.details!.reservedFor ??
                  state.service!.details!.placeName,
            ),
          ],
        );
      },
    );
  }
}

