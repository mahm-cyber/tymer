import 'package:provide_service/provide_service.dart';
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
    required this.onServiceRequestDetailsTapped,
    required this.navigateToFulfillServiceRequest,
    super.key,
  });

  final UserRepository userRepository;
  final ServiceRepository serviceRepository;
  final VoidCallback onServiceRequestDetailsTapped;
  final VoidCallback navigateToFulfillServiceRequest;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProvideServiceCubit>(
      create: (_) => ProvideServiceCubit(
        userRepository: userRepository,
        serviceRepository: serviceRepository,
        onServiceRequestDetailsTapped: onServiceRequestDetailsTapped,
        navigateToFulfillServiceRequest: navigateToFulfillServiceRequest,
      ),
      child: const ProvideServiceView(),
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
    return BlocConsumer<ProvideServiceCubit, ProvideServiceState>(
      listener: (context, state) {
        if (state.runningServiceRequest != null) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: l10n.userHasRunningServiceRequestSnackBarMessage,
            ),
          );
        }
        if (state.locationDataStatus == LocationDataStatus.failure) {
          Navigator.pop(context);
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: l10n.locationDataFailureSnackBarMessage,
            ),
          );
        }
      },
      builder: (context, state) {
        final loading = state.serviceRequestsFetchStatus == FetchStatus.loading;
        final noServiceRequests = state.serviceRequests?.isEmpty == true;
        final cubit = context.read<ProvideServiceCubit>();
        final failure = state.serviceRequestsFetchStatus == FetchStatus.failure;
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
                body: loading
                    ? const CenteredCircularProgressIndicator()
                    : noServiceRequests
                        ? Center(
                            child: Text(l10n.noServiceRequestsText),
                          )
                        : failure
                            ? ExceptionIndicator(
                                onTryAgain: cubit.init,
                              )
                            : Column(
                                children: [
                                  Expanded(
                                    child: ListView.separated(
                                      padding: EdgeInsets.only(
                                        left: theme.screenMargin,
                                        right: theme.screenMargin,
                                        top: Spacing.xxLarge,
                                      ),
                                      itemCount: state
                                          .ascendingSortedServiceRequests!
                                          .length,
                                      separatorBuilder: (context, index) =>
                                          VerticalGap.medium(),
                                      itemBuilder: (context, index) {
                                        final service = state
                                                .ascendingSortedServiceRequests![
                                            index];
                                        return ServiceRequestCard(
                                          onTapped: () => cubit
                                              .onViewServiceRequestDetailsTapped(
                                                  service),
                                          service: service,
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(theme.screenMargin),
                                    child: TymerElevatedButton(
                                      label: l10n.showInMapButtonLabel,
                                      onTap: () {},
                                      height: 50,
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
          ),
        );
      },
    );
  }
}
