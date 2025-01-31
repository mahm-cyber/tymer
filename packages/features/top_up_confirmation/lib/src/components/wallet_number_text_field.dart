import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:top_up_confirmation/src/l10n/top_up_confirmation_localizations.dart';
import 'package:top_up_confirmation/src/top_up_confirmation_cubit.dart';

class WalletNumberTextField extends StatefulWidget {
  const WalletNumberTextField({super.key});

  @override
  State<WalletNumberTextField> createState() => _WalletNumberTextFieldState();
}

class _WalletNumberTextFieldState extends State<WalletNumberTextField> {
  final _walletNumberFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _setUpWalletNumberFieldFocusListener();
  }

  void _setUpWalletNumberFieldFocusListener() {
    final cubit = context.read<TopUpConfirmationCubit>();
    _walletNumberFocusNode.addListener(() {
      if (!_walletNumberFocusNode.hasFocus) {
        cubit.onWalletNumberUnfocused();
      }
    });
  }

  @override
  void dispose() {
    _walletNumberFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopUpConfirmationCubit, TopUpConfirmationState>(
      builder: (context, state) {
        final cubit = context.read<TopUpConfirmationCubit>();
        final walletNumberError = 
            state.walletNumber.isNotValid ? state.walletNumber.error : null;
        final isSubmissionInProgress = 
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final l10n = TopUpConfirmationLocalizations.of(context);

        return TextFormField(
          enabled: !isSubmissionInProgress,
          focusNode: _walletNumberFocusNode,
          onChanged: cubit.onWalletNumberChanged,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            isDense: true,
            labelText: l10n.walletNumberTextFieldLabel,
            prefixIcon: const SvgAsset(
              AssetPathConstants.mobilePath,
            ),
            hintText: l10n.walletNumberTextFieldLabel,
            errorText: walletNumberError == DynamicValidationError.empty
                ? l10n.requiredFieldErrorMessage
                : null,
          ),
        );
      },
    );
  }
} 