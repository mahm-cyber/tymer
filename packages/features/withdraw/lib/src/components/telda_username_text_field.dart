import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:withdraw/src/l10n/withdraw_localizations.dart';
import 'package:withdraw/src/withdraw_cubit.dart';

class TeldaUsernameTextField extends StatefulWidget {
  const TeldaUsernameTextField({super.key});

  @override
  State<TeldaUsernameTextField> createState() => _TeldaUsernameTextFieldState();
}

class _TeldaUsernameTextFieldState extends State<TeldaUsernameTextField> {
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
        cubit.onTeldaUsernameUnfocused();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WithdrawCubit, WithdrawState>(builder: (context, state) {
      final cubit = context.read<WithdrawCubit>();
      final error =
          state.teldaUsername.isNotValid ? state.teldaUsername.error : null;
      final l10n = WithdrawLocalizations.of(context);
      final clL10n = ComponentLibraryLocalizations.of(context);

      return TextFormField(
        focusNode: _focusNode,
        onChanged: cubit.onTeldaUsernameChanged,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          isDense: true,
          helperText: '',
          prefixIcon: const Padding(
            padding: EdgeInsetsDirectional.only(start: 10),
            child: Text(
              '~',
              style: TextStyle(fontSize: 40),
            ),
          ),
          labelText: l10n.teldaUsernameTextFieldLabel,
          errorText: error == DynamicValidationError.empty
              ? clL10n.requiredFieldErrorMessage
              : null,
        ),
      );
    });
  }
}
