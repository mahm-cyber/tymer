import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:change_password/src/l10n/change_password_localizations.dart';

import 'package:change_password/src/change_password_cubit.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({
    super.key,
  });

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final _focusNode = FocusNode();
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ChangePasswordCubit>();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        cubit.onNewPasswordUnfocused();
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
        final newPasswordError =
            state.newPassword.isNotValid ? state.newPassword.error : null;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final textTheme = Theme.of(context).textTheme;
        final l10n = ChangePasswordLocalizations.of(context);
        return TextField(
          textInputAction: TextInputAction.next,
          focusNode: _focusNode,
          onChanged: cubit.onNewPasswordChanged,
          enabled: !isSubmissionInProgress,
          obscureText: !isPasswordVisible,
          decoration: InputDecoration(
            prefixIcon: newPasswordError == PasswordValidationError.weak
                ? GestureDetector(
                    onTap: () => showModalBottomSheet(
                      context: context,
                      showDragHandle: true,
                      builder: (context) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          l10n.newPasswordTextFieldWeakPasswordErrorDescription,
                          style: textTheme.titleMedium,
                        ),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(
                        Icons.info_outline,
                        color: Colors.red,
                      ),
                    ),
                  )
                : const SvgAsset(
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
            labelText: l10n.newPasswordTextFieldLabel,
            hintText: l10n.newPasswordTextFieldHint,
            errorText: newPasswordError == PasswordValidationError.empty
                ? l10n.requiredTextFieldErrorMessage
                : newPasswordError == PasswordValidationError.weak
                    ? l10n.newPasswordWeakErrorMessage
                    : null,
          ),
        );
      },
    );
  }
}
