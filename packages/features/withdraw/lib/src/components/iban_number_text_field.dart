import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:withdraw/src/l10n/withdraw_localizations.dart';
import 'package:withdraw/src/withdraw_cubit.dart';

class IbanNumberTextField extends StatefulWidget {
  const IbanNumberTextField({super.key});

  @override
  State<IbanNumberTextField> createState() => _IbanNumberTextFieldState();
}

class _IbanNumberTextFieldState extends State<IbanNumberTextField> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _setUpFocusListener();
  }

  void _setUpFocusListener() {
    final cubit = context.read<WithdrawCubit>();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        cubit.onIbanNumberUnfocused();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WithdrawCubit, WithdrawState>(builder: (context, state) {
      final cubit = context.read<WithdrawCubit>();
      final error = state.ibanNumber.isNotValid ? state.ibanNumber.error : null;
      final l10n = WithdrawLocalizations.of(context);
      final clL10n = ComponentLibraryLocalizations.of(context);

      return TextFormField(
        focusNode: _focusNode,
        onChanged: cubit.onIbanNumberChanged,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          isDense: true,
          prefixIcon: const SvgAsset(AssetPathConstants.bankNoteBlackPath),
          labelText: l10n.ibanNumberTextFieldLabel,
          errorText: error == DynamicValidationError.empty
              ? clL10n.requiredFieldErrorMessage
              : error == DynamicValidationError.isNotIbanNumber
                  ? l10n.ibanNumberTextFieldError
                  : null,
        ),
      );
    });
  }
} 