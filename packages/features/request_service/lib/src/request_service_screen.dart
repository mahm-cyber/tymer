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
    required this.onGoToWalletTapped,
    required this.onServiceRequestSuccess,
    super.key,
  });

  final UserRepository userRepository;
  final ServiceRepository serviceRepository;
  final VoidCallback onGoToWalletTapped;
  final ValueSetter<int> onServiceRequestSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RequestServiceCubit>(
      create: (_) => RequestServiceCubit(
        userRepository: userRepository,
        serviceRepository: serviceRepository,
        onGoToWalletTapped: onGoToWalletTapped,
        onServiceRequestSuccess: onServiceRequestSuccess,
      ),
      child: const RequestServiceView(),
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
    return BlocConsumer<RequestServiceCubit, RequestServiceState>(
      listenWhen: (previous, current) =>
          previous.submissionStatus != current.submissionStatus,
      listener: (context, state) {
        final cubit = context.read<RequestServiceCubit>();
        if (state.error is InsufficientBalanceException) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: l10n.insufficientBalanceMessage,
              snackBarAction: SnackBarAction(
                label: l10n.addFundsButtonLabel,
                backgroundColor: colorScheme.error,
                onPressed: cubit.onGoToWalletTapped,
              ),
            ),
          );
        }
        if (state.submissionStatus == FormzSubmissionStatus.success) {
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              context: context,
              message: l10n.successfulServiceRequestMessage,
            ),
          );
          cubit.onServiceRequestSuccess(state.requestId!);
        }
      },
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
                  title: const SvgAsset(AssetPathConstants.whiteLogoPath),
                  toolbarHeight: 70,
                  iconTheme: IconThemeData(color: colorScheme.surface),
                ),
                body: loadingReservationServiceTypes
                    ? const CenteredCircularProgressIndicator()
                    : Column(
                        children: [
                          const FormFields(),
                          const RequestServiceButton(),
                          VerticalGap.small(),
                        ],
                      ),
              ),
              AppBarTitleContainer(
                top: 63,
                height: 30,
                title: isReservationServiceType
                    ? l10n.reservationServiceTypeAppBarTitle
                    : l10n.otherServiceTypeAppBarTitle,
              ),
              if (locationPickingInProgress) const GoogleMapWidget(),
            ],
          ),
        );
      },
    );
  }
}
