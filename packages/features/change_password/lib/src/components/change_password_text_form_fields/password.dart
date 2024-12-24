import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:change_password/src/l10n/change_password_localizations.dart';

import 'package:change_password/src/change_password_cubit.dart';

class Password extends StatefulWidget {
  const Password({
    super.key,
  });

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  final _focusNode = FocusNode();
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ChangePasswordCubit>();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        cubit.onPasswordUnfocused();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
      builder: (context, state) {
        final cubit = context.read<ChangePasswordCubit>();
        final passwordError =
            state.password.isNotValid ? state.password.error : null;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final l10n = ChangePasswordLocalizations.of(context);
        return TextField(
          textInputAction: TextInputAction.next,
          focusNode: _focusNode,
          onChanged: cubit.onPasswordChanged,
          enabled: !isSubmissionInProgress,
          obscureText: !isPasswordVisible,
          decoration: InputDecoration(

            prefixIcon: const SvgAsset(
              AssetPathConstants.lockPath,
            ),
            suffixIcon: GestureDetector(
              onTap: () =>
                  setState(() => isPasswordVisible = !isPasswordVisible),
              child: Icon(
                isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                size: 26,
              ),
            ),
            labelText: l10n.passwordTextFieldLabel,
            hintText: l10n.passwordTextFieldHint,
            errorText: passwordError == PasswordValidationError.empty
                ? l10n.requiredTextFieldErrorMessage
                : passwordError ==
                            PasswordValidationError.invalidCredentials
                        ? l10n.incorrectPasswordErrorMessage
                        : null,
          ),
        );
      },
    );
  }
}
