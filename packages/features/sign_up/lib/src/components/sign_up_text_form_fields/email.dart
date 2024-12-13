import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:sign_up/src/l10n/sign_up_localizations.dart';

import 'package:sign_up/src/sign_up_cubit.dart';

class Email extends StatefulWidget {
  const Email({
    super.key,
  });

  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<SignUpCubit>();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        cubit.onEmailUnfocused();
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
      final emailError = state.email.isNotValid ? state.email.error : null;
      final isSubmissionInProgress =
          state.submissionStatus == FormzSubmissionStatus.inProgress;
      // final theme = TymerTheme.of(context);
      final l10n = SignUpLocalizations.of(context);
      return TextField(
        enabled: !isSubmissionInProgress,
        focusNode: _focusNode,
        onChanged: cubit.onEmailChanged,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: const SvgAsset(
            AssetPathConstants.emailPath,
          ),
          labelText: l10n.emailTextFieldLabel,
          hintText: l10n.emailTextFieldHint,
          helperText: '',
          errorText: emailError == EmailValidationError.empty
              ? l10n.requiredTextFieldErrorMessage
              : emailError == EmailValidationError.invalidCredentials
                  ? l10n.invalidCredentialsErrorMessage
                  : emailError == EmailValidationError.invalidFormat
                      ? l10n.invalidEmailFormatErrorMessage
                      : emailError == EmailValidationError.alreadyRegistered
                          ? l10n.alreadyRegisteredErrorMessage
                          : null,
        ),
      );
    });
  }
}
