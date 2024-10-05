import 'package:domain_models/domain_models.dart';
import 'package:provide_service/src/components/components.dart';
import 'package:provide_service/src/l10n/provide_service_localizations.dart';
import 'package:provide_service/src/provide_service_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:service_repository/service_repository.dart';

import 'package:user_repository/user_repository.dart';

class ProvideServiceScreen extends StatelessWidget {
  const ProvideServiceScreen({
    required this.userRepository,
    required this.serviceRepository,
    super.key,
  });

  final UserRepository userRepository;
  final ServiceRepository serviceRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProvideServiceCubit>(
      create: (_) => ProvideServiceCubit(
        userRepository: userRepository,
        serviceRepository: serviceRepository,
      ),
      child: ProvideServiceView(),
    );
  }
}

class ProvideServiceView extends StatelessWidget {
  const ProvideServiceView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final colorScheme = theme.materialThemeData.colorScheme;
    final l10n = ProvideServiceLocalizations.of(context);
    return BlocBuilder<ProvideServiceCubit, ProvideServiceState>(
      builder: (context, state) {
        final loadingReservationServiceTypes =
            state.reservationServiceTypes == null;
        final locationPickingInProgress =
            state.locationPickingInProgress == true;
        final isReservationServiceType =
            state.serviceType == ServiceType.reservation;
        return GestureDetector(
          onTap: context.releaseFocus,
          child: Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  title: SvgAsset(AssetPathConstants.whiteLogoPath),
                  toolbarHeight: 70,
                  iconTheme: IconThemeData(color: colorScheme.surface),
                ),
                body: loadingReservationServiceTypes
                    ? const CenteredCircularProgressIndicator()
                    : Column(
                        children: [
                          FormFields(),
                          ProvideServiceButton(),
                          VerticalGap.small(),
                        ],
                      ),
              ),
              AppBarTitleContainer(
                top: 95,
                height: 30,
                title: isReservationServiceType
                    ? l10n.reservationServiceTypeAppBarTitle
                    : l10n.otherServiceTypeAppBarTitle,
              ),
              if (locationPickingInProgress) GoogleMapWidget(),
            ],
          ),
        );
      },
    );
  }
}
