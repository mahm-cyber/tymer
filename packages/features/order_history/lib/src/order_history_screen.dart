import 'package:order_history/src/l10n/order_history_localizations.dart';
import 'package:order_history/src/order_history_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:service_repository/service_repository.dart';

import 'package:user_repository/user_repository.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({
    required this.userRepository,
    required this.serviceRepository,
    required this.onCheckServiceRequestStatusTapped,
    super.key,
  });

  final UserRepository userRepository;
  final ServiceRepository serviceRepository;
  final ValueSetter<int> onCheckServiceRequestStatusTapped;

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<OrderHistoryCubit>(
      create: (_) => OrderHistoryCubit(
        userRepository: widget.userRepository,
        serviceRepository: widget.serviceRepository,
        onCheckServiceRequestStatusTapped:
            widget.onCheckServiceRequestStatusTapped,
      ),
      child: const OrderHistoryView(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final colorScheme = theme.materialThemeData.colorScheme;
    final l10n = OrderHistoryLocalizations.of(context);
    return BlocBuilder<OrderHistoryCubit, OrderHistoryState>(
      builder: (context, state) {
        final loading = state.serviceRequestsFetchStatus == FetchStatus.loading;
        final noServiceRequests = state.serviceRequests?.isEmpty == true;
        final cubit = context.read<OrderHistoryCubit>();
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
                            child: ExceptionIndicator(
                              onTryAgain: cubit.fetchServiceRequests,
                              message: l10n.noServiceRequestsText,
                              title: l10n.noServiceRequestsText,
                            ),
                          )
                        : failure
                            ? ExceptionIndicator(
                                onTryAgain: cubit.fetchServiceRequests,
                              )
                            : RefreshIndicator(
                                onRefresh: cubit.fetchServiceRequests,
                                child: ListView.separated(
                                  padding: EdgeInsets.only(
                                    left: theme.screenMargin,
                                    right: theme.screenMargin,
                                    top: Spacing.xxLarge,
                                  ),
                                  itemCount: state
                                      .ascendingSortedServiceRequests!.length,
                                  separatorBuilder: (context, index) =>
                                      VerticalGap.medium(),
                                  itemBuilder: (context, index) {
                                    final service = state
                                        .ascendingSortedServiceRequests![index];
                                    return ServiceRequestCard(
                                      onTapped: () => cubit
                                          .onViewServiceRequestDetailsTapped(
                                              service),
                                      shouldShowRequestStatus: true,
                                      service: service,
                                    );
                                  },
                                ),
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
