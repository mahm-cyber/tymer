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
  final String _sessionToken = const Uuid().v4();

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

        final shouldShowLocationButtonManually = Platform.isAndroid &&
            (locationServiceDisabled ||
                isPermissionDenied ||
                isPermissionDeniedForever);

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

        void onPlaceDetailsWithCoordinatesReceived(prediction) {
          final bool hasCoordinates =
              prediction.lat != null && prediction.lng != null;
          if (hasCoordinates) {
            final latLng = LatLng(
              double.parse(prediction.lat!),
              double.parse(prediction.lng!),
            );
            _controller.future.then(
              (controller) {
                controller.animateCamera(
                  CameraUpdate.newLatLng(
                    latLng,
                  ),
                );
              },
            );
            cubit.onLocationChanged(latLng);
          }
        }

        // Helper method to return the correct icon based on the permission status
        Widget? getPermissionIcon() {
          return (isPermissionDenied || isPermissionDeniedForever)
              ? Icon(Icons.gps_fixed,
                  color: Colors.black.withAlpha((255 * 0.5).toInt()))
              : null;
        }

        void onMapCreated(GoogleMapController controller) async {
          _controller.complete(controller);
          if (state.location.value != null) {
            controller.animateCamera(
              CameraUpdate.newLatLng(state.location.value!),
            );
            return;
          } else if (!locationServiceDisabled &&
              !isPermissionDenied &&
              !isPermissionDeniedForever) {
            final position = await geo.Geolocator.getCurrentPosition();
            final latLng = LatLng(position.latitude, position.longitude);
            controller.animateCamera(
              CameraUpdate.newLatLng(latLng),
            );
          }
        }

        return BackButtonListener(
          onBackButtonPressed: onBackPressed,
          child: Scaffold(
            appBar: AppBar(toolbarHeight: 0),
            body: Stack(
              children: [
                // Google Map
                GoogleMap(
                  onMapCreated: onMapCreated,
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
                    padding: EdgeInsetsDirectional.only(
                      start: theme.screenMargin * 1.5,
                      end: theme.screenMargin * 4,
                    ),
                    child: places.GooglePlacesAutoCompleteTextFormField(
                      enableSuggestions: true,
                      textEditingController: _searchController,
                      sessionToken: _sessionToken,
                      googleAPIKey: 'AIzaSyCfqmfFlq559OlNw9Zdx_YgDSeRZnN09Pc',
                      decoration: InputDecoration(
                        hintText: l10n.searchPlaceTextFieldHint,
                        labelText: l10n.searchPlaceTextFieldLabel,
                        labelStyle: const TextStyle(color: Colors.purple),
                        border: const OutlineInputBorder(),
                      ),
                      maxLines: 1,
                      countries: const ['eg'],
                      overlayContainerBuilder: (child) => Material(
                        elevation: 1.0,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        child: child,
                      ),
                      onPlaceDetailsWithCoordinatesReceived:
                          onPlaceDetailsWithCoordinatesReceived,
                      onSuggestionClicked: (prediction) {
                        _searchController.text = prediction.description ?? '';
                      },
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
                if (shouldShowLocationButtonManually)
                  PositionedDirectional(
                    end: Spacing.medium,
                    top: 15,
                    child: GestureDetector(
                      onTap: onLocationSettingsTap,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: getPermissionIconColor(),
                          borderRadius: BorderRadius.circular(5),
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
