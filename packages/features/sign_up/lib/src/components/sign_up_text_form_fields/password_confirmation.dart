import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:sign_up/src/l10n/sign_up_localizations.dart';

import 'package:sign_up/src/sign_up_cubit.dart';

class PasswordConfirmation extends StatefulWidget {
  const PasswordConfirmation({
    super.key,
  });

  @override
  State<PasswordConfirmation> createState() => _PasswordConfirmationState();
}

class _PasswordConfirmationState extends State<PasswordConfirmation> {
  bool isPasswordVisible = false;
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<SignUpCubit>();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        cubit.onPasswordConfirmationUnfocused();
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
    return BlocBuilder<SignUpCubit, SignUpState>(builder: (context, state) {
      final cubit = context.read<SignUpCubit>();
      final passwordConfirmationError = state.passwordConfirmation.isNotValid
          ? state.passwordConfirmation.error
          : null;
      final isSubmissionInProgress =
          state.submissionStatus == FormzSubmissionStatus.inProgress;
      final l10n = SignUpLocalizations.of(context);
      return TextField(
        focusNode: _focusNode,
        onChanged: cubit.onPasswordConfirmationChanged,
        obscureText: !isPasswordVisible,
        decoration: InputDecoration(
          hintText: l10n.passwordConfirmationTextFieldHint,
          labelText: l10n.passwordConfirmationTextFieldLabel,
          helperText: '',
          errorText: passwordConfirmationError ==
                  PasswordConfirmationValidationError.empty
              ? l10n.requiredTextFieldErrorMessage
              : passwordConfirmationError ==
                      PasswordConfirmationValidationError.doesNotMatch
                  ? l10n.passwordConfirmationTextFieldError
                  : null,
          prefixIcon: SvgAsset(
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
