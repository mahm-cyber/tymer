import 'package:domain_models/domain_models.dart';
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
    return BlocBuilder<ProvideServiceCubit, ProvideServiceState>(
      builder: (context, state) {
        final loading = state.serviceRequestsFetchStatus == FetchStatus.loading;
        final noServiceRequests = state.serviceRequests?.isEmpty == true;
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
                        : Column(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                  padding: EdgeInsets.only(
                                    left: theme.screenMargin,
                                    right: theme.screenMargin,
                                    top: Spacing.xxLarge,
                                  ),
                                  itemCount: state.ascendingSortedServiceRequests!.length,
                                  separatorBuilder: (context, index) =>
                                      VerticalGap.medium(),
                                  itemBuilder: (context, index) {
                                    final service =
                                    state.ascendingSortedServiceRequests![index];
                                    return ServiceRequestCard(
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
                top: 95,
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

class ServiceRequestCard extends StatelessWidget {
  const ServiceRequestCard({
    super.key,
    required this.service,
  });

  final Service service;

  @override
  Widget build(BuildContext context) {
    final l10n = ProvideServiceLocalizations.of(context);
    final theme = TymerTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = theme.materialThemeData.colorScheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.medium,
        vertical: Spacing.small,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width -
                    (2 * theme.screenMargin) -
                    170,
                child: Text(
                  service.details.reservedFor ?? service.details.placeName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              VerticalGap.medium(),
              Row(
                children: [
                  const SvgAsset(
                    AssetPathConstants.footPrintFilledPath,
                  ),
                  HorizontalGap.medium(),
                  Text(
                    l10n.distanceToServiceLocation(
                      service.distanceBetweenProviderAndServiceLocation!
                          .toStringAsFixed(0),
                    ),
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              //price
              VerticalGap.medium(),
              Row(
                children: [
                  const SvgAsset(
                    AssetPathConstants.bankNotePath,
                  ),
                  HorizontalGap.medium(),
                  Text(
                    '${service.price.toStringAsFixed(0)} EGP',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          TymerElevatedButton(
            label: l10n.viewButtonLabel,
            onTap: () {},
            width: 120,
            height: 30,
          ),
        ],
      ),
    );
  }
}
