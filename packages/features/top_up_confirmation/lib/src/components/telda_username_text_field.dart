import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:top_up_confirmation/src/top_up_confirmation_cubit.dart';
import 'package:top_up_confirmation/top_up_confirmation.dart';

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
    final cubit = context.read<TopUpConfirmationCubit>();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        cubit.onTeldaUsernameUnfocused();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopUpConfirmationCubit, TopUpConfirmationState>(
        builder: (context, state) {
      final cubit = context.read<TopUpConfirmationCubit>();
      final error =
          state.teldaUsername.isNotValid ? state.teldaUsername.error : null;
      final l10n = TopUpConfirmationLocalizations.of(context);
      final clL10n = ComponentLibraryLocalizations.of(context);

      return TextFormField(
        focusNode: _focusNode,
        onChanged: cubit.onTeldaUsernameChanged,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          isDense: true,
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
