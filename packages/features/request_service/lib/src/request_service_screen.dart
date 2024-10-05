import 'package:domain_models/domain_models.dart';
import 'package:form_fields/form_fields.dart';
import 'package:request_service/src/components/components.dart';
import 'package:request_service/src/l10n/request_service_localizations.dart';
import 'package:request_service/src/request_service_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:service_repository/service_repository.dart';

import 'package:user_repository/user_repository.dart';

class RequestServiceScreen extends StatelessWidget {
  const RequestServiceScreen({
    required this.userRepository,
    required this.serviceRepository,
    super.key,
  });

  final UserRepository userRepository;
  final ServiceRepository serviceRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RequestServiceCubit>(
      create: (_) => RequestServiceCubit(
        userRepository: userRepository,
        serviceRepository: serviceRepository,
      ),
      child: RequestServiceView(),
    );
  }
}

class RequestServiceView extends StatelessWidget {
  const RequestServiceView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final colorScheme = theme.materialThemeData.colorScheme;
    final l10n = RequestServiceLocalizations.of(context);
    return BlocBuilder<RequestServiceCubit, RequestServiceState>(
      builder: (context, state) {
        final isReservationServiceType =
            state.serviceType == ServiceType.reservation;
        final loadingReservationServiceTypes =
            state.reservationServiceTypes == null;
        final locationPickingInProgress =
            state.locationPickingInProgress == true;

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
                    : locationPickingInProgress
                        ? GoogleMapWidget()
                        : Column(
                            children: [
                              Expanded(
                                child: ListView(
                                  children: [
                                    VerticalGap.xLarge(),
                                    VerticalGap.medium(),
                                    if (isReservationServiceType) ...[
                                      ReservationServiceTypePicker(),
                                      VerticalGap.xSmall(),
                                      ReservationNameTextField(),
                                      VerticalGap.xSmall(),
                                    ],
                                    DatePickerTextField(),
                                    VerticalGap.xSmall(),
                                    PlaceNameTextField(),
                                    VerticalGap.xSmall(),
                                    AddressTextField(),
                                    VerticalGap.xSmall(),
                                    LocationPickerTextField(),
                                    VerticalGap.xSmall(),
                                    PricePickerTextField(),
                                    VerticalGap.xSmall(),
                                  ],
                                ),
                              ),
                              RequestServiceButton(),
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
            ],
          ),
        );
      },
    );
  }
}

