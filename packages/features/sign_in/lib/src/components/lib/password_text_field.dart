import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:sign_in/sign_in.dart';
import 'package:sign_in/src/sign_in_cubit.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _setUpPasswordFieldFocusListener();
  }

  void _setUpPasswordFieldFocusListener() {
    final cubit = context.read<SignInCubit>();
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        cubit.onPasswordUnfocused();
      }
    });
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        final cubit = context.read<SignInCubit>();
        final passwordError =
            state.password.isNotValid ? state.password.error : null;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final l10n = SignInLocalizations.of(context);
        final theme = TymerTheme.of(context);
        final textTheme = Theme.of(context).textTheme;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.passwordTextFieldLabel,
                style:
                    textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
              VerticalGap.medium(),
              TextFormField(
                obscureText: !isPasswordVisible,
                initialValue: state.rememberMe.password,
                textInputAction: TextInputAction.done,
                focusNode: _passwordFocusNode,
                onChanged: cubit.onPasswordChanged,
                enabled: !isSubmissionInProgress,
                onEditingComplete: cubit.onSubmit,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: Spacing.small,
                    vertical: Spacing.small,
                  ),
                  isDense: true,
                  suffixIconConstraints: const BoxConstraints(
                    minWidth: 40,
                    minHeight: 0,
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 40,
                    minHeight: 0,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () =>
                        setState(() => isPasswordVisible = !isPasswordVisible),
                    child: Icon(
                      isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.password,
                  ),
                  hintText: l10n.passwordTextFieldLabel,
                  errorText: passwordError == PasswordValidationError.empty
                      ? l10n.requiredFieldErrorMessage
                      : passwordError ==
                              PasswordValidationError.invalidCredentials
                          ? l10n.invalidCredentialsErrorMessage
                          : null,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
