import 'package:accept_service_request/src/accept_service_request_cubit.dart';
import 'package:accept_service_request/src/l10n/accept_service_request_localizations.dart';
import 'package:domain_models/domain_models.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_repository/service_repository.dart';
import 'package:user_repository/user_repository.dart';

class AcceptServiceRequestScreen extends StatelessWidget {
  const AcceptServiceRequestScreen({
    required this.serviceRepository,
    required this.userRepository,
    required this.onAcceptServiceRequestSuccess,
    super.key,
  });

  final ServiceRepository serviceRepository;
  final UserRepository userRepository;
  final ValueSetter<int> onAcceptServiceRequestSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AcceptServiceRequestCubit>(
      create: (_) => AcceptServiceRequestCubit(
        serviceRepository: serviceRepository,
        userRepository: userRepository,
        onAcceptServiceRequestSuccess: onAcceptServiceRequestSuccess,
      ),
      child: const AcceptServiceRequestView(),
    );
  }
}

class AcceptServiceRequestView extends StatelessWidget {
  const AcceptServiceRequestView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final colorScheme = theme.materialThemeData.colorScheme;
    final l10n = AcceptServiceRequestLocalizations.of(context);
    final clL10n = ComponentLibraryLocalizations.of(context);
    final locale = Localizations.localeOf(context);
    return BlocConsumer<AcceptServiceRequestCubit, AcceptServiceRequestState>(
      listenWhen: (previous, current) =>
          previous.submissionStatus != current.submissionStatus,
      listener: (context, state) {
        final cubit = context.read<AcceptServiceRequestCubit>();
        if (state.submissionStatus == SubmissionStatus.success) {
          cubit.onAcceptServiceRequestSuccess(state.service!.id!);
        }
        if (state.submissionStatus == SubmissionStatus.failure) {
          final alreadyAcceptedByAnotherProvider =
              state.error is ServiceRequestAlreadyProcessed;
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: alreadyAcceptedByAnotherProvider
                  ? l10n.serviceRequestNotAvailableAnymoreErrorMessage
                  : null,
            ),
          );
          if (alreadyAcceptedByAnotherProvider) {
            Navigator.of(context).pop();
          }
        }
      },
      builder: (context, state) {
        final coordinates = state.service!.location.coordinates;
        final latLng = LatLng(
          coordinates[0],
          coordinates[1],
        );
        final cubit = context.read<AcceptServiceRequestCubit>();
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
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    if (state.isViewingLocation) {
                      cubit.closeMap();
                      return;
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: state.isViewingLocation
                        ? BackButtonListener(
                            onBackButtonPressed: () async {
                              cubit.closeMap();
                              return true;
                            },
                            child: GoogleMap(
                              myLocationEnabled: true,
                              myLocationButtonEnabled: true,
                              markers: {
                                // if (state.myLocation != null)
                                //   Marker(
                                //     markerId:  MarkerId(
                                //       l10n.myLocationMarkerTitle,
                                //     ),
                                //     position: LatLng(
                                //       state.myLocation!.latitude!,
                                //       state.myLocation!.longitude!,
                                //     ),

                                //     infoWindow: InfoWindow(
                                //       title: l10n.myLocationInfoWindowTitle,
                                //     ),
                                //   ),
                                Marker(
                                  markerId: const MarkerId('service-location'),
                                  position: latLng,
                                  infoWindow: InfoWindow(
                                    title: l10n.distanceToServiceLocation(
                                        '${state.service?.distanceBetweenProviderAndServiceLocation?.toStringAsFixed(0)}'),
                                    snippet:
                                        '${state.service?.price!.localizeDouble(locale)} ${clL10n.eyptianPoundLetters}',
                                  ),
                                ),
                              },
                              initialCameraPosition:
                                  CameraPosition(target: latLng, zoom: 10),
                            ),
                          )
                        : Column(
                            children: [
                              VerticalGap.large(),
                              VerticalGap.large(),
                              Expanded(
                                child: ServiceRequestDetailsWidget(
                                  service: state.service!,
                                  onViewServiceOnMap: cubit.onViewServiceOnMap,
                                ),
                              ),
                            ],
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: theme.screenMargin,
                        vertical: Spacing.medium),
                    child: state.submissionStatus == SubmissionStatus.submitting
                        ? TymerElevatedButton.inProgress(
                            label: l10n.acceptButtonLabel,
                          )
                        : TymerElevatedButton(
                            label: l10n.acceptButtonLabel,
                            onTap: cubit.onSubmit,
                          ),
                  ),
                ],
              ),
            ),
            AppBarTitleContainer(
              top: theme.smallAppBarTitleContainerHeight,
              height: 30,
              title: l10n.appBarTitle,
            ),
          ],
        );
      },
    );
  }
}
