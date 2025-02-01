import 'package:choose_withdraw_method/choose_withdraw_method.dart';
import 'package:choose_withdraw_method/src/choose_withdraw_method_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:user_repository/user_repository.dart';
import 'package:wallet_repository/wallet_repository.dart';

class ChooseWithdrawMethodScreen extends StatelessWidget {
  const ChooseWithdrawMethodScreen({
    required this.userRepository,
    required this.walletRepository,
    required this.onWithdrawMethodTapped,
    required this.onWithdrawalPaymentHistoryTapped,
    super.key,
  });

  final UserRepository userRepository;
  final WalletRepository walletRepository;
  final VoidCallback onWithdrawMethodTapped;
  final VoidCallback onWithdrawalPaymentHistoryTapped;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChooseWithdrawMethodCubit>(
      create: (_) => ChooseWithdrawMethodCubit(
        userRepository: userRepository,
        walletRepository: walletRepository,
        onWithdrawMethodTapped: onWithdrawMethodTapped,
        onWithdrawalPaymentHistoryTapped: onWithdrawalPaymentHistoryTapped,
      ),
      child: const ChooseWithdrawMethodView(),
    );
  }
}

class ChooseWithdrawMethodView extends StatelessWidget {
  const ChooseWithdrawMethodView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = ChooseWithdrawMethodLocalizations.of(context);
    final cubit = context.read<ChooseWithdrawMethodCubit>();
    return GestureDetector(
      onTap: context.releaseFocus,
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: const SvgAsset(AssetPathConstants.whiteLogoPath),
              iconTheme: const IconThemeData(color: Colors.white),
              toolbarHeight: 160,
            ),
            body: BlocBuilder<ChooseWithdrawMethodCubit, ChooseWithdrawMethodState>(
              builder: (context, state) {
                if (state.paymentMethodsLoadingStatus == LoadingStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.paymentMethodsLoadingStatus == LoadingStatus.failure) {
                  return ExceptionIndicator(
                    onTryAgain: cubit.getWithdrawMethods,
                  );
                }

                return PaymentMethodsList(
                  bankCardEnabled: false,
                  onPaymentMethodTapped: cubit.setPaymentMethodType,
                  paymentMethods: state.paymentMethods!,
                  onViewHistoryTapped: cubit.onWithdrawalPaymentHistoryTapped,
                  viewHistoryButtonLabel: l10n.withdrawalHistoryButtonLabel,
                );
              },
            ),
          ),
          AppBarTitleContainer(
            title: l10n.appBarTitle,
          ),
        ],
      ),
    );
  }
} 