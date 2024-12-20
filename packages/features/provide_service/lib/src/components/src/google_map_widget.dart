import 'dart:async';

import 'package:domain_models/domain_models.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provide_service/src/l10n/provide_service_localizations.dart';
import 'package:provide_service/src/provide_service_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart' as geo;

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({
    super.key,
  });

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  StreamSubscription<geo.ServiceStatus>? _geoLocationServiceStatusSubscription;
  geo.ServiceStatus? locationServiceStatus;

  void getLocationServiceStatus() async {
    final isServiceEnabled = await Location().serviceEnabled();
    locationServiceStatus = isServiceEnabled
        ? geo.ServiceStatus.enabled
        : geo.ServiceStatus.disabled;
    setState(() {});

    _geoLocationServiceStatusSubscription =
        geo.Geolocator.getServiceStatusStream().listen((locationServiceStatus) {
      this.locationServiceStatus = locationServiceStatus;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getLocationServiceStatus();
  }

  @override
  void dispose() {
    _geoLocationServiceStatusSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProvideServiceCubit, ProvideServiceState>(
      builder: (context, state) {
        final cubit = context.read<ProvideServiceCubit>();
        final theme = TymerTheme.of(context);
        final l10n = ProvideServiceLocalizations.of(context);
        final clL10n = ComponentLibraryLocalizations.of(context);
        final locale = Localizations.localeOf(context);
        return BackButtonListener(
          onBackButtonPressed: () async {
            cubit.switchMapView();
            return true;
          },
          child: Stack(
            children: [
              GoogleMap(
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                markers: {
                  if (state.serviceRequests?.isNotEmpty == true)
                    // Marker(
                    //   markerId: const MarkerId('location'),
                    //   position: state.location.value!,
                    // ),
                    for (final Service service in state.serviceRequests!)
                      Marker(
                        markerId: MarkerId(service.id!.toString()),
                        position: LatLng(
                          service.location.coordinates[0],
                          service.location.coordinates[1],
                        ),
                        infoWindow: InfoWindow(
                          title: service.requestDetails!.placeName,
                          snippet: '${service.price!.localizeDouble(locale)} ${clL10n.eyptianPoundLetters}',
                          onTap: () {
                            cubit.onViewServiceRequestDetailsTapped(service);
                          },
                        ),
                      ),
                },
                initialCameraPosition: const CameraPosition(
                  target: LatLng(
                    30.0444,
                    31.2357,
                  ),
                  zoom: 11.5,
                ),
              ),
              Positioned(
                bottom: Spacing.medium,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: theme.screenMargin * 4,
                    vertical: Spacing.medium,
                  ),
                  child: TymerElevatedButton(
                    onTap: cubit.switchMapView,
                    label: l10n.showInListViewButtonLabel,
                  ),
                ),
              ),
              if (locationServiceStatus == geo.ServiceStatus.disabled)
                PositionedDirectional(
                  end: Spacing.medium,
                  top: 10,
                  child: GestureDetector(
                    onTap: () async {
                      await geo.Geolocator.openLocationSettings();
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      color: Colors.black.withAlpha( 255 *0),
                    ),
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
