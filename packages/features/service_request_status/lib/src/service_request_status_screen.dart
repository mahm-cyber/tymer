import 'package:service_request_status/src/l10n/service_request_status_localizations.dart';
import 'package:service_request_status/src/service_request_status_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:service_repository/service_repository.dart';

import 'package:user_repository/user_repository.dart';

import 'components/components.dart';

class ServiceRequestStatusScreen extends StatelessWidget {
  const ServiceRequestStatusScreen({
    required this.userRepository,
    required this.serviceRepository,
    required this.onGoToWalletTapped,
    super.key,
  });

  final UserRepository userRepository;
  final ServiceRepository serviceRepository;
  final VoidCallback onGoToWalletTapped;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceRequestStatusCubit>(
      create: (_) => ServiceRequestStatusCubit(
        userRepository: userRepository,
        serviceRepository: serviceRepository,
        onGoToWalletTapped: onGoToWalletTapped,
      ),
      child: ServiceRequestStatusView(),
    );
  }
}

class ServiceRequestStatusView extends StatelessWidget {
  const ServiceRequestStatusView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final colorScheme = theme.materialThemeData.colorScheme;
    final l10n = ServiceRequestStatusLocalizations.of(context);
    return BlocConsumer<ServiceRequestStatusCubit, ServiceRequestStatusState>(
      listenWhen: (previous, current) =>
          previous.submissionStatus != current.submissionStatus,
      listener: (context, state) {
        // final cubit = context.read<ServiceRequestStatusCubit>();
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: context.releaseFocus,
          child: Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  title: SvgAsset(AssetPathConstants.whiteLogoPath),
                  toolbarHeight: 160,
                  iconTheme: IconThemeData(color: colorScheme.surface),
                ),
                body: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: theme.screenMargin * 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RequestStatusStep(
                        title: 'l10n.findingSomeoneStepTitle',
                        status: RequestStatus.loading,
                      ),
                      VerticalGap.medium(),
                      RequestStatusStep(
                        title: 'l10n.processingStepTitle',
                        status: RequestStatus.idle,
                      ),
                      VerticalGap.medium(),
                      RequestStatusStep(
                        title: 'l10n.completeStepTitle',
                        status: RequestStatus.done,
                      ),
                    ],
                  ),
                ),
              ),
              AppBarTitleContainer(
                title: l10n.appBarTitle,
                icon: SvgAsset(
                  AssetPathConstants.potPath,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
