import 'package:domain_models/domain_models.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
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
    final textTheme = Theme.of(context).textTheme;
    return BlocConsumer<OrderHistoryCubit, OrderHistoryState>(
      listener: (context, state) {
        final cubit = context.read<OrderHistoryCubit>();
        cubit.serviceRequestsPagingController.value = state.toPagingState();
      },
      builder: (context, state) {
        final cubit = context.read<OrderHistoryCubit>();
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
                body: Column(
                  children: [
                    VerticalGap.large(),
                    VerticalGap.medium(),
                    SizedBox(
                      height: 50,
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            HorizontalGap.medium(),
                        padding: EdgeInsets.symmetric(
                            horizontal: theme.screenMargin),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final currentServiceStatus =
                              ServiceStatus.values[index];
                          final label = serviceRequestStatusToLocalizedString(
                            currentServiceStatus,
                            ComponentLibraryLocalizations.of(context),
                          );
                          return BlocSelector<OrderHistoryCubit,
                              OrderHistoryState, ServiceStatus>(
                            selector: (state) => state.statusFilter,
                            builder: (context, statusFilter) {
                              final isSelected =
                                  statusFilter == currentServiceStatus;
                              return ChoiceChip(
                                onSelected: (_) =>
                                    cubit.setFilterBy(currentServiceStatus),
                                selected: isSelected,
                                label: Text(label),
                                labelStyle: isSelected
                                    ? textTheme.bodyMedium?.copyWith(
                                        color: colorScheme.surface,
                                      )
                                    : null,
                                checkmarkColor: colorScheme.surface,
                              );
                            },
                          );
                        },
                        itemCount: ServiceStatus.values.length,
                      ),
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: cubit.reFetchFirstPage,
                        child: PagedListView.separated(
                          padding: EdgeInsets.symmetric(
                              horizontal: theme.screenMargin),
                          pagingController:
                              cubit.serviceRequestsPagingController,
                          separatorBuilder: (context, index) =>
                              VerticalGap.medium(),
                          builderDelegate: PagedChildBuilderDelegate<Service>(
                            itemBuilder: (context, service, index) {
                              final isLastItem = index ==
                                  cubit.serviceRequestsPagingController
                                          .itemList!.length -
                                      1;
                              return Column(
                                children: [
                                  if (index == 0) VerticalGap.medium(),
                                  ServiceRequestCard(
                                    onTapped: () =>
                                        cubit.onViewServiceRequestDetailsTapped(
                                            service),
                                    shouldShowRequestStatus: true,
                                    service: service,
                                  ),
                                  if(isLastItem) VerticalGap.large(),
                                ],
                              );
                            },
                            firstPageErrorIndicatorBuilder: (context) {
                              return ExceptionIndicator(
                                onTryAgain: cubit.reFetchFirstPage,
                              );
                            },
                            newPageProgressIndicatorBuilder: (_) {
                              return const NewPageProgressIndicator();
                            },
                            noItemsFoundIndicatorBuilder: (_) {
                              return NoItemsFoundIndicator(
                                message: l10n.noServiceRequestsText,
                              );
                            },
                            newPageErrorIndicatorBuilder: (_) {
                              return NextPageExceptionIndicator(
                                onTryAgain: cubit.reFetchNextSearchListPage,
                              );
                            },
                          ),
                        ),
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

extension on OrderHistoryState {
  PagingState<int, Service> toPagingState() {
    return PagingState(
      itemList: serviceRequests,
      nextPageKey: nextPage,
      error: nextListPageLoadError,
    );
  }
}
