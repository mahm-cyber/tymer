import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:payment_history/src/components/src/payment_card.dart';
import 'package:payment_history/src/l10n/payment_history_localizations.dart';
import 'package:payment_history/src/payment_history_cubit.dart';
import 'package:user_repository/user_repository.dart';
import 'package:wallet_repository/wallet_repository.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({
    required this.userRepository,
    required this.walletRepository,
    super.key,
  });

  final UserRepository userRepository;
  final WalletRepository walletRepository;

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaymentHistoryCubit>(
      create: (_) => PaymentHistoryCubit(
        userRepository: widget.userRepository,
        walletRepository: widget.walletRepository,
      ),
      child: const PaymentHistoryView(),
    );
  }
}

class PaymentHistoryView extends StatelessWidget {
  const PaymentHistoryView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final colorScheme = theme.materialThemeData.colorScheme;
    final l10n = PaymentHistoryLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return BlocConsumer<PaymentHistoryCubit, PaymentHistoryState>(
      listener: (context, state) {
        final cubit = context.read<PaymentHistoryCubit>();
        cubit.paymentsPagingController.value = state.toPagingState();
      },
      builder: (context, state) {
        final cubit = context.read<PaymentHistoryCubit>();
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
                    VerticalGap.large(),
                    SizedBox(
                      height: 45,
                      // width: 300,
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(
                          horizontal: theme.screenMargin,
                        ),
                        separatorBuilder: (context, index) =>
                            HorizontalGap.medium(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final currentPaymentMethodType = PaymentMethodType
                              .values
                              .where((e) => e != PaymentMethodType.bankCard)
                              .toList()[index];
                          final label = paymentMethodTypeToLocalizedString(
                            currentPaymentMethodType,
                            ComponentLibraryLocalizations.of(context),
                          );
                          return BlocSelector<PaymentHistoryCubit,
                              PaymentHistoryState, PaymentMethodType?>(
                            selector: (state) => state.paymentMethodType,
                            builder: (context, paymentMethodType) {
                              final isSelected =
                                  paymentMethodType == currentPaymentMethodType;
                              return ChoiceChip(
                                onSelected: (_) =>
                                    cubit.filterByPaymentMethodType(
                                        currentPaymentMethodType),
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
                        itemCount: PaymentMethodType.values.length - 1,
                      ),
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: cubit.reFetchFirstPage,
                        child: PagedListView.separated(
                          cacheExtent: 1000,
                          padding: EdgeInsets.symmetric(
                            horizontal: theme.screenMargin,
                          ),
                          pagingController: cubit.paymentsPagingController,
                          separatorBuilder: (context, index) =>
                              VerticalGap.medium(),
                          builderDelegate: PagedChildBuilderDelegate<Payment>(
                            itemBuilder: (context, payment, index) {
                              final isLastItem = index ==
                                  cubit.paymentsPagingController.itemList!
                                          .length -
                                      1;
                              return Column(
                                children: [
                                  if (index == 0) VerticalGap.small(),
                                  PaymentCard(
                                    payment: payment,
                                    userToken: state.userToken,
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
                                message:
                                    state.paymentType == TransactionType.topup
                                        ? l10n.noTopupPaymentsText
                                        : l10n.noWithdrawalPaymentsText,
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
                title: state.paymentType == TransactionType.topup
                    ? l10n.topupHistoryAppBarTitle
                    : l10n.withdrawHistoryAppBarTitle,
              ),
            ],
          ),
        );
      },
    );
  }
}

extension on PaymentHistoryState {
  PagingState<int, Payment> toPagingState() {
    return PagingState(
      itemList: ascendingSortedPayments,
      nextPageKey: nextPage,
      error: nextListPageLoadError,
    );
  }
}

String paymentMethodTypeToLocalizedString(
  PaymentMethodType paymentMethodType,
  ComponentLibraryLocalizations l10n,
) {
  switch (paymentMethodType) {
    case PaymentMethodType.bankCard:
      return l10n.bankCard;
    case PaymentMethodType.vodafoneCash:
      return l10n.vodafoneCash;
    case PaymentMethodType.orangeCash:
      return l10n.orangeCash;
    case PaymentMethodType.etisalatCash:
      return l10n.etisalatCash;
    case PaymentMethodType.instaPay:
      return l10n.instaPay;
    case PaymentMethodType.bankTransfer:
      return l10n.bankTransfer;
    case PaymentMethodType.telda:
      return l10n.telda;
  }
}
