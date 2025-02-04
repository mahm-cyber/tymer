import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:withdraw/src/l10n/withdraw_localizations.dart';
import 'package:withdraw/src/withdraw_cubit.dart';

class WithdrawAmountInputField extends StatefulWidget {
  const WithdrawAmountInputField({
    super.key,
  });

  @override
  State<WithdrawAmountInputField> createState() =>
      _WithdrawAmountInputFieldState();
}

class _WithdrawAmountInputFieldState extends State<WithdrawAmountInputField> {
  final _topUpAmountFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _setUpWithdrawAmountFieldFocusListener();
  }

  void _setUpWithdrawAmountFieldFocusListener() {
    final cubit = context.read<WithdrawCubit>();
    _topUpAmountFocusNode.addListener(() {
      if (!_topUpAmountFocusNode.hasFocus) {
        cubit.onWithdrawAmountUnfocused();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WithdrawCubit, WithdrawState>(builder: (context, state) {
      final cubit = context.read<WithdrawCubit>();
      final withdrawAmountError =
          state.withdrawAmount.isNotValid ? state.withdrawAmount.error : null;
      final isSubmissionInProgress =
          state.submissionStatus == FormzSubmissionStatus.inProgress;
      final clL10n = ComponentLibraryLocalizations.of(context);
      final l10n = WithdrawLocalizations.of(context);

      return TextFormField(
        enableInteractiveSelection: false,
        enabled: !isSubmissionInProgress,
        focusNode: _topUpAmountFocusNode,
        onChanged: cubit.onWithdrawAmountChanged,
        keyboardType: TextInputType.number,
        
        decoration: InputDecoration(
          prefixIcon: const SvgAsset(
            AssetPathConstants.bankNoteBlackPath,
          ),
          isDense: true,
          labelText: l10n.withdrawAmountTextFieldLabel,
          hintText: l10n.withdrawAmountTextFieldHint,
          errorText: withdrawAmountError == DynamicValidationError.empty
              ? clL10n.requiredFieldErrorMessage
              : withdrawAmountError == DynamicValidationError.isNotNumber
                  ? l10n.isNotNumberTextFieldErrorMessage
                  : withdrawAmountError == DynamicValidationError.isNotGreaterThanZero
                      ? l10n.isNotGreaterThanZeroTextFieldErrorMessage(
                          state.withdrawMethods?.minimumAmount?.toInt() ?? 0)
                      : null,
        ),
      );
    });
  }
}
