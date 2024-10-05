import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:request_service/src/l10n/request_service_localizations.dart';
import 'package:request_service/src/request_service_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class GoogleMapWidget extends StatelessWidget {
  const GoogleMapWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestServiceCubit, RequestServiceState>(
      builder: (context, state) {
        final cubit = context.read<RequestServiceCubit>();
        final theme = TymerTheme.of(context);
        final l10n = RequestServiceLocalizations.of(context);
        return Stack(
          children: [
            GoogleMap(
              onTap: (LatLng latLng) {
                cubit.onLocationChanged(latLng);
              },
              markers: {
                if (state.location.value != null)
                  Marker(
                    markerId: MarkerId('location'),
                    position: state.location.value!,
                  ),
              },
              initialCameraPosition: CameraPosition(
                target: state.location.value ??
                    LatLng(
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
                  horizontal: theme.screenMargin,
                  vertical: Spacing.medium,
                ),
                child: TymerElevatedButton(
                  onTap: cubit.onLocationConfirmed,
                  label: l10n.locationPickingCompletedButton,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
