import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_confirmation/src/top_up_confirmation_cubit.dart';
import 'package:user_repository/user_repository.dart';
import 'package:wallet_repository/wallet_repository.dart';

class TopUpConfirmationScreen extends StatelessWidget {
  const TopUpConfirmationScreen({
    required this.userRepository,
    required this.walletRepository,
    super.key,
  });

  final UserRepository userRepository;
  final WalletRepository walletRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TopUpConfirmationCubit>(
      create: (_) => TopUpConfirmationCubit(
        userRepository: userRepository,
        walletRepository: walletRepository,
      ),
      child: const TopUpConfirmationView(),
    );
  }
}

class TopUpConfirmationView extends StatelessWidget {
  const TopUpConfirmationView({super.key});

  @override
  Widget build(BuildContext context) {
    final cl10n = ComponentLibraryLocalizations.of(context);
    return BlocBuilder<TopUpConfirmationCubit, TopUpConfirmationState>(
      builder: (context, state) {
        final pickedMethod = state.paymentMethods?.pickedPaymentMethodType;
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: const SvgAsset(AssetPathConstants.whiteLogoPath),
                iconTheme: const IconThemeData(color: Colors.white),
                toolbarHeight: 160,
              ),
              body: Container(), // Add your content here
            ),
            AppBarTitleContainer(
              title: switch (pickedMethod) {
                null => 'l10n.error',
                PaymentMethodType.bankCard => cl10n.bankCard,
                PaymentMethodType.vodafoneCash => cl10n.vodafoneCash,
                PaymentMethodType.orangeCash => cl10n.orangeCash,
                PaymentMethodType.etisalatCash => cl10n.etisalatCash,
                PaymentMethodType.instaPay => cl10n.instaPay,
                PaymentMethodType.bankTransfer => cl10n.bankTransfer,
              },
            ),
          ],
        );
      },
    );
  }
}
