import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:choose_top_up_method/src/choose_top_up_method_cubit.dart';
import 'package:choose_top_up_method/src/l10n/choose_top_up_method_localizations.dart';

import 'package:user_repository/user_repository.dart';
import 'package:wallet_repository/wallet_repository.dart';

class ChooseTopUpMethodScreen extends StatelessWidget {
  const ChooseTopUpMethodScreen({
    required this.userRepository,
    required this.walletRepository,
    required this.onTopUpMethodTapped,
    super.key,
  });

  final UserRepository userRepository;
  final WalletRepository walletRepository;
  final VoidCallback onTopUpMethodTapped;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChooseTopUpMethodCubit>(
      create: (_) => ChooseTopUpMethodCubit(
        userRepository: userRepository,
        walletRepository: walletRepository,
        onTopUpMethodTapped: onTopUpMethodTapped,
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
    final clL10n = ComponentLibraryLocalizations.of(context);
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
            body: BlocBuilder<ChooseTopUpMethodCubit, ChooseTopUpMethodState>(
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

                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      VerticalGap.xxLarge(),
                      ListTile(
                        title: Text(clL10n.bankCard),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        leading: const Icon(Icons.credit_card),
                        onTap: () => cubit
                            .setPaymentMethodType(PaymentMethodType.bankCard),
                      ),
                      if (state.paymentMethods!.vodafoneCash.enabled)
                        ListTile(
                          title: Text(clL10n.vodafoneCash),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 16),
                          leading: const Icon(Icons.phone_android),
                          onTap: () => cubit.setPaymentMethodType(
                              PaymentMethodType.vodafoneCash),
                        ),
                      if (state.paymentMethods!.orangeCash.enabled)
                        ListTile(
                          title: Text(clL10n.orangeCash),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 16),
                          leading: const Icon(Icons.phone_android),
                          onTap: () => cubit.setPaymentMethodType(
                              PaymentMethodType.orangeCash),
                        ),
                      if (state.paymentMethods!.etisalatCash.enabled)
                        ListTile(
                          title: Text(clL10n.etisalatCash),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 16),
                          leading: const Icon(Icons.phone_android),
                          onTap: () => cubit.setPaymentMethodType(
                              PaymentMethodType.etisalatCash),
                        ),
                      if (state.paymentMethods!.instaPay.enabled)
                        ListTile(
                          title: Text(clL10n.instaPay),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 16),
                          leading: const Icon(Icons.flash_on),
                          onTap: () => cubit
                              .setPaymentMethodType(PaymentMethodType.instaPay),
                        ),
                      if (state.paymentMethods!.bankTransfer.enabled)
                        ListTile(
                          title: Text(clL10n.bankTransfer),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 16),
                          leading: const Icon(Icons.account_balance),
                          onTap: () => cubit.setPaymentMethodType(
                              PaymentMethodType.bankTransfer),
                        ),
                    ],
                  ),
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
