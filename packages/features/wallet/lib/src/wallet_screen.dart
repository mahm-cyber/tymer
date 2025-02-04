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

class WalletScreen extends StatefulWidget {
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
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<WalletCubit>(
      create: (_) => WalletCubit(
        userRepository: widget.userRepository,
        walletRepository: widget.walletRepository,
        onTopUpTapped: widget.onTopUpTapped,
        onWithdrawTapped: widget.onWithdrawTapped,
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
    final theme = TymerTheme.of(context);
    final colorScheme = theme.materialThemeData.colorScheme;
    final clL10n = ComponentLibraryLocalizations.of(context);
    final locale = Localizations.localeOf(context);
    final textTheme = Theme.of(context).textTheme;
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
                  title: const SvgAsset(
                    AssetPathConstants.whiteLogoPath,
                    height: 30,
                  ),
                  toolbarHeight: 70,
                  iconTheme: IconThemeData(color: colorScheme.surface),
                ),
                body: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      VerticalGap.xLarge(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Spacing.medium,
                          vertical: Spacing.small,
                        ),
                        decoration: BoxDecoration(
                          color: theme.secondaryContainerBgColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SvgAsset(AssetPathConstants.bankNotePath),
                            HorizontalGap.small(),
                            if (state.balance != null)
                              Text(
                                '${l10n.balance} ${state.balance!.localizeDouble(locale)} ${clL10n.eyptianPoundLetters}',
                                style: textTheme.labelMedium
                                    ?.copyWith(color: colorScheme.primary),
                              ),
                          ],
                        ),
                      ),
                      VerticalGap.small(),
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
                                PagedChildBuilderDelegate<Transaction>(
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
                              firstPageProgressIndicatorBuilder: (_) {
                                return const SizedBox.shrink();
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

extension WalletStateToPagingState on WalletState {
  PagingState<int, Transaction> toPagingState() {
    return PagingState(
      itemList: transactions,
      nextPageKey: nextPage,
      error: nextListPageLoadError,
    );
  }
}
