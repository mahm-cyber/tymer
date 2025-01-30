import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:top_up_information/src/top_up_information_cubit.dart';
import 'package:top_up_information/src/l10n/top_up_information_localizations.dart';

import 'package:user_repository/user_repository.dart';
import 'package:wallet_repository/wallet_repository.dart';

import 'components/components.dart';

class TopUpInformationScreen extends StatelessWidget {
  const TopUpInformationScreen({
    required this.userRepository,
    required this.walletRepository,
    super.key,
  });

  final UserRepository userRepository;
  final WalletRepository walletRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TopUpInformationCubit>(
      create: (_) => TopUpInformationCubit(
        userRepository: userRepository,
        walletRepository: walletRepository,
      ),
      child: const TopUpInformationView(),
    );
  }
}

class TopUpInformationView extends StatelessWidget {
  const TopUpInformationView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = TopUpInformationLocalizations.of(context);
    return GestureDetector(
      onTap: context.releaseFocus,
      child: BlocBuilder<TopUpInformationCubit, TopUpInformationState>(
        builder: (context, state) {
          if (state.paymentMethods == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final paymentMethods = state.paymentMethods!;
          final pickedMethod = paymentMethods.pickedPaymentMethodType;

          Widget content;
          switch (pickedMethod) {
            // case PaymentMethodType.bankCard:
            //   content = BankCardInfo(bankCard: paymentMethods.bankCard);
            //   break;
            case PaymentMethodType.vodafoneCash:
              content = VodafoneCashInfo(
                vodafoneCash: paymentMethods.vodafoneCash,
              );
              break;
            case PaymentMethodType.orangeCash:
              content = OrangeCashInfo(orangeCash: paymentMethods.orangeCash);
              break;
            case PaymentMethodType.etisalatCash:
              content =
                  EtisalatCashInfo(etisalatCash: paymentMethods.etisalatCash);
              break;
            case PaymentMethodType.instaPay:
              content = InstaPayInfo(instaPay: paymentMethods.instaPay);
              break;
            case PaymentMethodType.bankTransfer:
              content =
                  BankTransferInfo(bankTransfer: paymentMethods.bankTransfer);
              break;
            default:
              content = Center(child: Text(l10n.error));
          }

          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  title: const SvgAsset(AssetPathConstants.whiteLogoPath),
                  iconTheme: const IconThemeData(color: Colors.white),
                  toolbarHeight: 160,
                ),
                body: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      VerticalGap.xxLarge(),
                      content,
                    ],
                  ),
                ),
              ),
              AppBarTitleContainer(
                title: switch (pickedMethod) {
                  null => l10n.error,
                  PaymentMethodType.bankCard => l10n.bankCard,
                  PaymentMethodType.vodafoneCash => l10n.vodafoneCash,
                  PaymentMethodType.orangeCash => l10n.orangeCash,
                  PaymentMethodType.etisalatCash => l10n.etisalatCash,
                  PaymentMethodType.instaPay => l10n.instaPay,
                  PaymentMethodType.bankTransfer => l10n.bankTransfer,
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
