import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:request_service/src/l10n/request_service_localizations.dart';
import 'package:request_service/src/request_service_cubit.dart';
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
    return BlocBuilder<RequestServiceCubit, RequestServiceState>(
      builder: (context, state) {
        final cubit = context.read<RequestServiceCubit>();
        final theme = TymerTheme.of(context);
        final l10n = RequestServiceLocalizations.of(context);
        return BackButtonListener(
          onBackButtonPressed: () async {
            cubit.onLocationConfirmed();
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 0,
            ),
            body: Stack(
              children: [
                GoogleMap(
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  onTap: (LatLng latLng) {
                    cubit.onLocationChanged(latLng);
                  },
                  markers: {
                    if (state.location.value != null)
                      Marker(
                        markerId: const MarkerId('location'),
                        position: state.location.value!,
                      ),
                  },
                  initialCameraPosition: CameraPosition(
                    target: state.location.value ??
                        const LatLng(
                          30.0444,
                          31.2357,
                        ),
                    zoom: 14.5,
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
                      onTap: cubit.onLocationConfirmed,
                      label: l10n.locationPickingCompletedButton,
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
                        color: Colors.black.withOpacity(0),
                      ),
                    ),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
