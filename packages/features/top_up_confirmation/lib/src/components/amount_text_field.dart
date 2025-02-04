import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:top_up_confirmation/src/l10n/top_up_confirmation_localizations.dart';
import 'package:top_up_confirmation/src/top_up_confirmation_cubit.dart';

class AmountTextField extends StatefulWidget {
  const AmountTextField({super.key});

  @override
  State<AmountTextField> createState() => _AmountTextFieldState();
}

class _AmountTextFieldState extends State<AmountTextField> {
  final _amountFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _setUpAmountFieldFocusListener();
  }

  void _setUpAmountFieldFocusListener() {
    final cubit = context.read<TopUpConfirmationCubit>();
    _amountFocusNode.addListener(() {
      if (!_amountFocusNode.hasFocus) {
        cubit.onAmountUnfocused();
      }
    });
  }

  @override
  void dispose() {
    _amountFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopUpConfirmationCubit, TopUpConfirmationState>(
      builder: (context, state) {
        final cubit = context.read<TopUpConfirmationCubit>();
        final amountError = state.amount.isNotValid ? state.amount.error : null;
        final isSubmissionInProgress = 
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final l10n = TopUpConfirmationLocalizations.of(context);

        return TextFormField(
          enabled: !isSubmissionInProgress,
          focusNode: _amountFocusNode,
          onChanged: cubit.onAmountChanged,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            isDense: true,
            labelText: l10n.amountTextFieldLabel,
            prefixIcon: const SvgAsset(
              AssetPathConstants.bankNoteBlackPath,
            ),
            hintText: l10n.amountTextFieldLabel,
            errorText: amountError == DynamicValidationError.empty
                ? l10n.requiredFieldErrorMessage
                : amountError == DynamicValidationError.isNotNumber
                    ? l10n.invalidAmountFormatErrorMessage
                    : amountError == DynamicValidationError.isNotGreaterThanZero
                        ? l10n.isNotGreaterThanZeroTextFieldErrorMessage
                        : null,
          ),
        );
      },
    );
  }
} 