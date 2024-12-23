import 'package:dispute_repository/dispute_repository.dart';
import 'package:disputes/src/l10n/disputes_localizations.dart';
import 'package:domain_models/domain_models.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:disputes/src/disputes_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';

import 'package:user_repository/user_repository.dart';

class DisputesScreen extends StatefulWidget {
  const DisputesScreen({
    required this.userRepository,
    required this.disputeRepository,
    required this.onDisputeTapped,
    super.key,
  });

  final UserRepository userRepository;
  final DisputeRepository disputeRepository;
  final ValueSetter<int> onDisputeTapped;

  @override
  State<DisputesScreen> createState() => _DisputesScreenState();
}

class _DisputesScreenState extends State<DisputesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DisputesCubit>(
      create: (_) => DisputesCubit(
        userRepository: widget.userRepository,
        disputeRepository: widget.disputeRepository,
        onDisputeTapped: widget.onDisputeTapped,
      ),
      child: const DisputesView(),
    );
  }
}

class DisputesView extends StatelessWidget {
  const DisputesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final colorScheme = theme.materialThemeData.colorScheme;
    final l10n = DisputesLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return BlocConsumer<DisputesCubit, DisputesState>(
      listener: (context, state) {
        final cubit = context.read<DisputesCubit>();
        cubit.serviceRequestsPagingController.value = state.toPagingState();
      },
      builder: (context, state) {
        final cubit = context.read<DisputesCubit>();
        final isRequesterChats = state.userTypeFilter == UserType.requester;
        final isProviderChats = state.userTypeFilter == UserType.provider;
        return GestureDetector(
          onTap: context.releaseFocus,
          child: Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  title: const SvgAsset(
                    AssetPathConstants.whiteLogoPath,
                    height: 30,
                  ),
                  toolbarHeight: 70,
                  iconTheme: IconThemeData(color: colorScheme.surface),
                ),
                body: Column(
                  children: [
                    VerticalGap.xLarge(),
                    SizedBox(
                      height: 45,
                      child: RowBuilder.separated(
                        separatorBuilder: (context, index) =>
                            HorizontalGap.medium(),
                        mainAxisAlignment: MainAxisAlignment.center,
                        itemBuilder: (context, index) {
                          final currentServiceRequestFetchMode =
                              UserType.values[index];
                          final label = userTypeToLocalizedString(
                            currentServiceRequestFetchMode,
                            ComponentLibraryLocalizations.of(context),
                          );
                          return BlocSelector<DisputesCubit, DisputesState,
                              UserType>(
                            selector: (state) => state.userTypeFilter,
                            builder: (context, serviceRequestsFetchMode) {
                              final isSelected = serviceRequestsFetchMode ==
                                  currentServiceRequestFetchMode;
                              return ChoiceChip(
                                onSelected: (_) => cubit.filterByUserType(
                                  currentServiceRequestFetchMode,
                                ),
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
                        itemCount: UserType.values.length,
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            HorizontalGap.medium(),
                        padding: EdgeInsets.symmetric(
                            horizontal: theme.screenMargin),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final currentDisputeStatus =
                              DisputeStatus.values[index];
                          final label = disputeStatusToLocalizedString(
                            currentDisputeStatus,
                            ComponentLibraryLocalizations.of(context),
                          );
                          return BlocSelector<DisputesCubit, DisputesState,
                              DisputeStatus>(
                            selector: (state) => state.disputeStatusFilter,
                            builder: (context, statusFilter) {
                              final isSelected =
                                  statusFilter == currentDisputeStatus;
                              return ChoiceChip(
                                onSelected: (_) =>
                                    cubit.setFilterByDisputeStatus(
                                        currentDisputeStatus),
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
                        itemCount: DisputeStatus.values.length,
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
                          builderDelegate: PagedChildBuilderDelegate<Dispute>(
                            itemBuilder: (context, dispute, index) {
                              final isLastItem = index ==
                                  cubit.serviceRequestsPagingController
                                          .itemList!.length -
                                      1;
                              final clL10n =
                                  ComponentLibraryLocalizations.of(context);

                              final isRequesterRefunded =
                                  dispute.status == DisputeStatus.refunded;
                              final idDisputeDenied =
                                  dispute.status == DisputeStatus.denied;

                              final resolution = getDisputeResolutionDetails(
                                isRequesterRefunded,
                                idDisputeDenied,
                                isRequesterChats,
                                isProviderChats,
                                clL10n,
                              );
                              return Column(
                                children: [
                                  if (index == 0) VerticalGap.medium(),
                                  ServiceRequestCard(
                                    onTapped: () =>
                                        cubit.onGoToDisputeChatTapped(
                                      dispute,
                                    ),
                                    shouldShowRequestStatus: true,
                                    service: dispute.serviceRequest!,
                                    disputeStatusWidget: ServiceStatusWidget(
                                      color: resolution.color,
                                      label: resolution.label,
                                    ),
                                    height: 110,
                                  ),
                                  if (isLastItem) VerticalGap.large(),
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
                                message: l10n.noDisputesIndicatorText,
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

extension on DisputesState {
  PagingState<int, Dispute> toPagingState() {
    return PagingState(
      itemList: ascendingSortedDisputes,
      nextPageKey: nextPage,
      error: nextListPageLoadError,
    );
  }
}
