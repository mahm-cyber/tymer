import 'dart:async';
import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart'
    as places;
import 'package:location/location.dart';
import 'package:request_service/src/l10n/request_service_localizations.dart';
import 'package:request_service/src/request_service_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:uuid/uuid.dart';

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
  geo.LocationPermission? locationPermissionStatus;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  String _sessionToken = const Uuid().v4();

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

  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      getLocationServiceStatus();
      geo.Geolocator.checkPermission().then((value) {
        locationPermissionStatus = value;
        setState(() {});
      });
      getLocationServiceStatus();
    }
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

        final locationServiceDisabled =
            locationServiceStatus == geo.ServiceStatus.disabled;
        final isPermissionDenied =
            locationPermissionStatus == geo.LocationPermission.denied;
        final isPermissionDeniedForever =
            locationPermissionStatus == geo.LocationPermission.deniedForever;

        // Handles back button press to confirm location
        Future<bool> onBackPressed() async {
          cubit.onLocationConfirmed();
          return true;
        }

        // Handles location settings and permissions
        Future<void> onLocationSettingsTap() async {
          if (isPermissionDenied) {
            final permission = await geo.Geolocator.requestPermission();
            locationPermissionStatus = permission;
            await cubit.onLocationConfirmed();
            await Future.delayed(const Duration(milliseconds: 100));
            await cubit.onLocationPickerTapped();
            return;
          } else if (isPermissionDeniedForever) {
            await geo.Geolocator.openAppSettings();
            final permission = await geo.Geolocator.checkPermission();
            locationPermissionStatus = permission;
            cubit.onLocationConfirmed();
            await Future.delayed(const Duration(milliseconds: 100));
            cubit.onLocationPickerTapped();
            return;
          } else if (locationServiceDisabled) {
            await geo.Geolocator.openLocationSettings();
            setState(() {});
          }
        }

        // Helper method to determine icon color based on permissions
        Color getPermissionIconColor() {
          if (isPermissionDenied || isPermissionDeniedForever) {
            return Colors.white;
          }
          if (locationServiceDisabled) {
            return Colors.transparent; // Invisible icon for disabled service
          }
          return Colors.black.withAlpha(0);
        }

        // Helper method to return the correct icon based on the permission status
        Widget? getPermissionIcon() {
          return (isPermissionDenied || isPermissionDeniedForever)
              ? Icon(Icons.gps_fixed,
                  color: Colors.black.withAlpha((255 * 0.5).toInt()))
              : null;
        }

        return BackButtonListener(
          onBackButtonPressed: onBackPressed,
          child: Scaffold(
            appBar: AppBar(toolbarHeight: 0),
            body: Stack(
              children: [
                // Google Map
                GoogleMap(
                  onMapCreated: (GoogleMapController controller) async {
                    _controller.complete(controller);
                    if (state.location.value != null) {
                      controller.animateCamera(
                        CameraUpdate.newLatLng(state.location.value!),
                      );
                      return;
                    } else if (!locationServiceDisabled &&
                        !isPermissionDenied &&
                        !isPermissionDeniedForever) {
                      final position =
                          await geo.Geolocator.getCurrentPosition();
                      final latLng =
                          LatLng(position.latitude, position.longitude);
                      controller.animateCamera(
                        CameraUpdate.newLatLng(latLng),
                      );
                    }
                  },
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  onTap: (LatLng latLng) => cubit.onLocationChanged(latLng),
                  markers: {
                    if (state.location.value != null)
                      Marker(
                        markerId: const MarkerId('location'),
                        position: state.location.value!,
                      ),
                  },
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(30.0444, 31.2357),
                    zoom: 14.5,
                  ),
                ),

                // Search bar
                Positioned(
                  top: Spacing.medium,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: theme.screenMargin * 5,
                    ),
                    child: places.GooglePlacesAutoCompleteTextFormField(
                      textEditingController: _searchController,
                      sessionToken: _sessionToken,
                      googleAPIKey: 'AIzaSyCKkPJMVmdqAkxN41uehsdra-qgOxg-xbE',
                      decoration: const InputDecoration(
                        hintText: 'Enter your address',
                        labelText: 'Address',
                        labelStyle: TextStyle(color: Colors.purple),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      // proxyURL: _yourProxyURL,
                      maxLines: 1,
                      countries: const ['eg'],
                      debounceTime: 600,
                      overlayContainerBuilder: (child) => Material(
                        elevation: 1.0,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        child: child,
                      ),
                      onPlaceDetailsWithCoordinatesReceived: (prediction) {
                        print('placeDetails${prediction.lng}');
                      },
                      onSuggestionClicked: (prediction) =>
                          _searchController.text = prediction.description!,
                      minInputLength: 3,
                    ),
                  ),
                ),
                // Location confirmation button
                Positioned(
                  bottom: Spacing.medium,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: theme.screenMargin * 5,
                    ),
                    child: TymerElevatedButton(
                      onTap: cubit.onLocationConfirmed,
                      label: l10n.locationPickingCompletedButton,
                    ),
                  ),
                ),

                // Location settings permission icon
                if (Platform.isAndroid &&
                    (locationServiceDisabled ||
                        isPermissionDenied ||
                        isPermissionDeniedForever))
                  PositionedDirectional(
                    end: Spacing.medium,
                    top: 10,
                    child: GestureDetector(
                      onTap: onLocationSettingsTap,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: getPermissionIconColor(),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: getPermissionIcon(),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
