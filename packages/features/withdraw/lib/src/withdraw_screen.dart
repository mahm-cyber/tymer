import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:wallet_repository/wallet_repository.dart';
import 'package:withdraw/src/components/components.dart';
import 'package:withdraw/src/l10n/withdraw_localizations.dart';
import 'package:withdraw/src/withdraw_cubit.dart';

import 'package:user_repository/user_repository.dart';

class WithdrawScreen extends StatelessWidget {
  const WithdrawScreen({
    required this.userRepository,
    required this.walletRepository,
    required this.onBackTapped,
    required this.onProvideServiceTapped,
    required this.onSuccess,
    super.key,
  });

  final UserRepository userRepository;
  final WalletRepository walletRepository;
  final VoidCallback onBackTapped;
  final VoidCallback onProvideServiceTapped;
  final VoidCallback onSuccess;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<WithdrawCubit>(
      create: (_) => WithdrawCubit(
        userRepository: userRepository,
        walletRepository: walletRepository,
        onBackTapped: onBackTapped,
        onProvideServiceTapped: onProvideServiceTapped,
        onSuccess: onSuccess,
      ),
      child: const WithdrawView(),
    );
  }
}

class WithdrawView extends StatelessWidget {
  const WithdrawView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final colorScheme = theme.materialThemeData.colorScheme;
    final l10n = WithdrawLocalizations.of(context);
    final cubit = context.read<WithdrawCubit>();
    final cl10n = ComponentLibraryLocalizations.of(context);

    return GestureDetector(
      onTap: context.releaseFocus,
      child: BlocConsumer<WithdrawCubit, WithdrawState>(
        listenWhen: (previous, current) =>
            previous.submissionStatus != current.submissionStatus,
        listener: (context, state) {
          if (state.submissionStatus == FormzSubmissionStatus.success) {
            cubit.onSuccess();
            showSnackBar(
              context: context,
              snackBar: SuccessSnackBar(
                context: context,
              ),
            );
          }
          if (state.submissionStatus == FormzSubmissionStatus.failure) {
            showSnackBar(
              context: context,
              snackBar: ErrorSnackBar(context: context),
            );
          }
          if (state.error is InsufficientBalanceException) {
            showSnackBar(
              context: context,
              snackBar: ErrorSnackBar(
                context: context,
                message: l10n.insufficientBalanceErrorMessage,
              ),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: cubit.onBackTapped,
                  ),
                  title: const SvgAsset(
                    AssetPathConstants.whiteLogoPath,
                    height: 30,
                  ),
                  toolbarHeight: 160,
                  iconTheme: IconThemeData(color: colorScheme.surface),
                ),
                body: Center(
                  child: ListView(
                    shrinkWrap: true,
                    padding:
                        EdgeInsets.symmetric(horizontal: theme.screenMargin),
                    children: [
                      const WithdrawAmountInputField(),
                      VerticalGap.medium(),
                      switch (state.paymentMethodType!) {
                        PaymentMethodType.vodafoneCash ||
                        PaymentMethodType.orangeCash ||
                        PaymentMethodType.etisalatCash =>
                          const WalletNumberTextField(),
                        PaymentMethodType.bankTransfer => Column(
                            children: [
                              const IbanNumberTextField(),
                              VerticalGap.medium(),
                              const BeneficiaryNameTextField(),
                            ],
                          ),
                        PaymentMethodType.instaPay => const InstaPayTextField(),
                        PaymentMethodType.telda =>
                          const TeldaUsernameTextField(),
                        _ => const SizedBox(),
                      },
                      VerticalGap.medium(),
                      state.submissionStatus == FormzSubmissionStatus.inProgress
                          ? TymerElevatedButton.inProgress(
                              label: l10n.withdrawConfirmButtonLabel,
                            )
                          : TymerElevatedButton(
                              label: l10n.withdrawConfirmButtonLabel,
                              onTap: cubit.onSubmit,
                            )
                    ],
                  ),
                ),
              ),
              AppBarTitleContainer(
                title: switch (state.paymentMethodType) {
                  null => 'l10n.error',
                  PaymentMethodType.bankCard => cl10n.bankCard,
                  PaymentMethodType.vodafoneCash => cl10n.vodafoneCash,
                  PaymentMethodType.orangeCash => cl10n.orangeCash,
                  PaymentMethodType.etisalatCash => cl10n.etisalatCash,
                  PaymentMethodType.instaPay => cl10n.instaPay,
                  PaymentMethodType.bankTransfer => cl10n.bankTransfer,
                  PaymentMethodType.telda => cl10n.telda,
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
