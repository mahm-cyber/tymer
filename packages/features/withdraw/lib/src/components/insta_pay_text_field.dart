import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:withdraw/src/l10n/withdraw_localizations.dart';
import 'package:withdraw/src/withdraw_cubit.dart';

class InstaPayTextField extends StatefulWidget {
  const InstaPayTextField({super.key});

  @override
  State<InstaPayTextField> createState() => _InstaPayTextFieldState();
}

class _InstaPayTextFieldState extends State<InstaPayTextField> {
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
        cubit.onInstaPayAddressUnfocused();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WithdrawCubit, WithdrawState>(builder: (context, state) {
      final cubit = context.read<WithdrawCubit>();
      final error = state.instantPaymentAddress.isNotValid
          ? state.instantPaymentAddress.error
          : null;
      final l10n = WithdrawLocalizations.of(context);
      final clL10n = ComponentLibraryLocalizations.of(context);

      return TextFormField(
        focusNode: _focusNode,
        onChanged: cubit.onInstaPayAddressChanged,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          isDense: true,
          prefixIcon: const Icon(Icons.electric_bolt_outlined),
          labelText: l10n.instantPaymentAddressTextFieldLabel,
          errorText: error == DynamicValidationError.empty
              ? clL10n.requiredFieldErrorMessage
              : null,
        ),
      );
    });
  }
}
