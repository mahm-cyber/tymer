import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:top_up_confirmation/src/top_up_confirmation_cubit.dart';
import 'package:top_up_confirmation/top_up_confirmation.dart';
import 'package:user_repository/user_repository.dart';
import 'package:wallet_repository/wallet_repository.dart';
import 'package:form_fields/form_fields.dart';
import 'components/amount_text_field.dart';
import 'components/wallet_number_text_field.dart';
import 'components/instant_payment_address_text_field.dart';

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
    final l10n = TopUpConfirmationLocalizations.of(context);
    final theme = TymerTheme.of(context);

    return BlocBuilder<TopUpConfirmationCubit, TopUpConfirmationState>(
      builder: (context, state) {
        final pickedMethod = state.paymentMethods?.pickedPaymentMethodType;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
//add release focus

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
                body: Padding(
                  padding: EdgeInsets.all(theme.screenMargin),
                  child: Column(
                    children: [
                      VerticalGap.large(),
                      const AmountTextField(),
                      VerticalGap.medium(),
                      if (state.paymentMethods?.pickedPaymentMethodType ==
                          PaymentMethodType.instaPay)
                        const InstantPaymentAddressTextField()
                      else if ([
                        PaymentMethodType.vodafoneCash,
                        PaymentMethodType.orangeCash,
                        PaymentMethodType.etisalatCash,
                      ].contains(state.paymentMethods?.pickedPaymentMethodType))
                        const WalletNumberTextField(),
                        
                      const Spacer(),
                      isSubmissionInProgress
                          ? TymerElevatedButton.inProgress(
                              label: l10n.confirmingButtonLabel,
                            )
                          : TymerElevatedButton(
                              onTap: context
                                  .read<TopUpConfirmationCubit>()
                                  .onSubmit,
                              label: l10n.confirmButtonLabel,
                            ),
                    ],
                  ),
                ),
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
          ),
        );
      },
    );
  }
}
