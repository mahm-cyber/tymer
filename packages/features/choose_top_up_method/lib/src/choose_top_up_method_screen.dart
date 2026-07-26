import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:choose_top_up_method/src/choose_top_up_method_cubit.dart';
import 'package:choose_top_up_method/src/l10n/choose_top_up_method_localizations.dart';

import 'package:user_repository/user_repository.dart';
import 'package:wallet_repository/wallet_repository.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ChooseTopUpMethodScreen extends StatelessWidget {
  const ChooseTopUpMethodScreen({
    required this.userRepository,
    required this.walletRepository,
    required this.onTopUpMethodTapped,
    required this.onBankCardTopUpTapped,
    required this.onTopUpHistoryTapped,
    super.key,
  });

  final UserRepository userRepository;
  final WalletRepository walletRepository;
  final VoidCallback onTopUpMethodTapped;
  final VoidCallback onBankCardTopUpTapped;
  final VoidCallback onTopUpHistoryTapped;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChooseTopUpMethodCubit>(
      create: (_) => ChooseTopUpMethodCubit(
        userRepository: userRepository,
        walletRepository: walletRepository,
        onTopUpMethodTapped: onTopUpMethodTapped,
        onBankCardTopUpTapped: onBankCardTopUpTapped,
        onTopUpHistoryTapped: onTopUpHistoryTapped,
      ),
      child: const ChooseTopUpMethodView(),
    );
  }
}

class ChooseTopUpMethodView extends StatelessWidget {
  const ChooseTopUpMethodView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = ChooseTopUpMethodLocalizations.of(context);
    final cubit = context.read<ChooseTopUpMethodCubit>();
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
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    TymerTheme.of(context).screenMargin + 8,
                    50,
                    TymerTheme.of(context).screenMargin + 8,
                    0,
                  ),
                  child: MarkdownBody(
                    data: l10n.topUpProcessingTimeNote,
                  ),
                ),
                BlocBuilder<ChooseTopUpMethodCubit, ChooseTopUpMethodState>(
                  builder: (context, state) {
                    if (state.paymentMethodsLoadingStatus ==
                        LoadingStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.paymentMethodsLoadingStatus ==
                        LoadingStatus.failure) {
                      return ExceptionIndicator(
                        onTryAgain: cubit.getPaymentMethods,
                      );
                    }

                    return PaymentMethodsList(
                      bankCardEnabled: state.paymentMethods!.cardEnabled,
                      onPaymentMethodTapped: cubit.setPaymentMethodType,
                      paymentMethods: state.paymentMethods!,
                      onViewHistoryTapped: cubit.onTopUpHistoryTapped,
                      viewHistoryButtonLabel: l10n.topUpHistoryButtonLabel,
                    );
                  },
                ),
              ],
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
