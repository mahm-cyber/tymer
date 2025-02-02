import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:withdraw/src/l10n/withdraw_localizations.dart';
import 'package:withdraw/src/withdraw_cubit.dart';

class BeneficiaryNameTextField extends StatefulWidget {
  const BeneficiaryNameTextField({super.key});

  @override
  State<BeneficiaryNameTextField> createState() => _BeneficiaryNameTextFieldState();
}

class _BeneficiaryNameTextFieldState extends State<BeneficiaryNameTextField> {
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
        cubit.onBeneficiaryNameUnfocused();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WithdrawCubit, WithdrawState>(builder: (context, state) {
      final cubit = context.read<WithdrawCubit>();
      final error = state.beneficiaryName.isNotValid ? state.beneficiaryName.error : null;
      final l10n = WithdrawLocalizations.of(context);
      final clL10n = ComponentLibraryLocalizations.of(context);

      return TextFormField(
        focusNode: _focusNode,
        onChanged: cubit.onBeneficiaryNameChanged,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          isDense: true,
          prefixIcon: const Icon(
            Icons.person,
          ),
          labelText: l10n.beneficiaryNameTextFieldLabel,
          errorText: error == DynamicValidationError.empty
              ? clL10n.requiredFieldErrorMessage
              : null,
        ),
      );
    });
  }
} 