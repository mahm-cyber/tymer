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
      },
      builder: (context, state) {
        final textTheme = Theme.of(context).textTheme;
        final cubit = context.read<FulfillServiceRequestCubit>();
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
                    Expanded(
                      child: ListView(
                        children: [
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
                    VerticalGap.medium(),
                    state.submissionStatus == FormzSubmissionStatus.inProgress
                        ? TymerElevatedButton.inProgress(
                            label: l10n.submitButtonLabel,
                          )
                        : TymerElevatedButton(
                            label: l10n.submitButtonLabel,
                            onTap: cubit.onSubmit,
                          ),
                    VerticalGap.small(),
                  ],
                ),
              ),
            ),
            AppBarTitleContainer(
              top: theme.smallAppBarTitleContainerHeight,
              height: 30,
              title: state.service!.details.reservedFor ??
                  state.service!.details.placeName,
            ),
          ],
        );
      },
    );
  }
}
