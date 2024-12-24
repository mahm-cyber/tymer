import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:change_password/src/l10n/change_password_localizations.dart';

import 'package:change_password/src/change_password_cubit.dart';

class NewPasswordConfirmation extends StatefulWidget {
  const NewPasswordConfirmation({
    super.key,
  });

  @override
  State<NewPasswordConfirmation> createState() => _NewPasswordConfirmationState();
}

class _NewPasswordConfirmationState extends State<NewPasswordConfirmation> {
  bool isPasswordVisible = false;
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ChangePasswordCubit>();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        cubit.onNewPasswordConfirmationUnfocused();
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
    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(builder: (context, state) {
      final cubit = context.read<ChangePasswordCubit>();
      final newPasswordConfirmationError = state.newPasswordConfirmation.isNotValid
          ? state.newPasswordConfirmation.error
          : null;
      final isSubmissionInProgress =
          state.submissionStatus == FormzSubmissionStatus.inProgress;
      final l10n = ChangePasswordLocalizations.of(context);
      return TextField(
        focusNode: _focusNode,
        onChanged: cubit.onNewPasswordConfirmationChanged,
        obscureText: !isPasswordVisible,
        decoration: InputDecoration(
          hintText: l10n.newPasswordConfirmationTextFieldHint,
          labelText: l10n.newPasswordConfirmationTextFieldLabel,
          errorText: newPasswordConfirmationError ==
                  PasswordConfirmationValidationError.empty
              ? l10n.requiredTextFieldErrorMessage
              : newPasswordConfirmationError ==
                      PasswordConfirmationValidationError.doesNotMatch
                  ? l10n.newPasswordConfirmationTextFieldError
                  : null,
          prefixIcon: const SvgAsset(
            AssetPathConstants.lockPath,
          ),
          suffixIcon: GestureDetector(
            onTap: () => setState(() => isPasswordVisible = !isPasswordVisible),
            child: Icon(
              isPasswordVisible ? Icons.visibility_off : Icons.visibility,
              size: 24,
            ),
          ),
        ),
        enabled: !isSubmissionInProgress,
      );
    });
  }
}
