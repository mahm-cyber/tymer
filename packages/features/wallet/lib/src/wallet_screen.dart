import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wallet/src/components/components.dart';
import 'package:wallet/src/wallet_cubit.dart';
import 'package:wallet/src/l10n/wallet_localizations.dart';

import 'package:user_repository/user_repository.dart';
import 'package:wallet_repository/wallet_repository.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({
    required this.userRepository,
    required this.walletRepository,
    required this.onTopUpTapped,
    required this.onWithdrawTapped,
    super.key,
  });

  final UserRepository userRepository;
  final WalletRepository walletRepository;
  final VoidCallback onTopUpTapped;
  final VoidCallback onWithdrawTapped;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WalletCubit>(
      create: (_) => WalletCubit(
        userRepository: userRepository,
        walletRepository: walletRepository,
        onTopUpTapped: onTopUpTapped,
        onWithdrawTapped: onWithdrawTapped,
      ),
      child: const WalletView(),
    );
  }
}

class WalletView extends StatelessWidget {
  const WalletView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = WalletLocalizations.of(context);
    final cubit = context.read<WalletCubit>();

    return BlocConsumer<WalletCubit, WalletState>(
      listener: (context, state) {
        cubit.transactionsPagingController.value = state.toPagingState();
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: context.releaseFocus,
          child: Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  title: const SvgAsset(AssetPathConstants.whiteLogoPath),
                  toolbarHeight: 160,
                ),
                body: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      VerticalGap.xxLarge(),
                      Wrap(
                        spacing: Spacing.medium,
                        runSpacing: Spacing.medium,
                        children: [
                          WalletButton(
                            icon: const SvgAsset(
                                AssetPathConstants.whiteBankNote),
                            title: l10n.withdrawalContainerTitle,
                            onTap: cubit.onNavigateToWithdrawTapped,
                          ),
                          WalletButton(
                            icon: const SvgAsset(
                                AssetPathConstants.arrowTowardsBox),
                            title: l10n.topUpContainerTitle,
                            onTap: cubit.onNavigateToTopUpTapped,
                          ),
                        ],
                      ),
                      VerticalGap.medium(),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: cubit.reFetchFirstPage,
                          child: PagedListView.separated(
                            
                            pagingController:
                                cubit.transactionsPagingController,
                            separatorBuilder: (context, index) =>
                                VerticalGap.medium(),
                            builderDelegate:
                                PagedChildBuilderDelegate<InAppTransaction>(
                              itemBuilder: (context, transaction, index) {
                                final isLastItem = index ==
                                    cubit.transactionsPagingController.itemList!
                                            .length -
                                        1;
                                return Column(
                                  children: [
                                    if (index == 0) VerticalGap.small(),
                                    TransactionCard(
                                      transaction: transaction,
                                    ),
                                    if (isLastItem)
                                      VerticalGap.custom(
                                        Spacing.xxxLarge + Spacing.small,
                                      ),
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
                                  message: l10n.noTransactionsText,
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
                      )
                    ],
                  ),
                ),
              ),
              AppBarTitleContainer(
                title: l10n.appBarTitle,
              ),
            ],
          ),
        );
      },
    );
  }
}


extension WalletStateToPagingState on WalletState {
  PagingState<int, InAppTransaction> toPagingState() {
    return PagingState(
      itemList: ascendingSortedTransactions,
      nextPageKey: nextPage,
      error: nextListPageLoadError,
    );
  }
}
