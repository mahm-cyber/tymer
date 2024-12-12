import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:verify_otp/src/l10n/verify_otp_localizations.dart';
import 'package:verify_otp/src/verify_otp_cubit.dart';

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
    final cubit = context.read<VerifyOtpCubit>();
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
    return BlocBuilder<VerifyOtpCubit, VerifyOtpState>(
      builder: (context, state) {
        final textTheme = Theme.of(context).textTheme;
        final error =
            state.newPassword.isNotValid ? state.newPassword.error : null;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final cubit = context.read<VerifyOtpCubit>();
        final l10n = VerifyOtpLocalizations.of(context);

        return TextField(
          obscuringCharacter: '*',
          obscureText: !isPasswordVisible,
          focusNode: _focusNode,
          decoration: InputDecoration(
            helperText: '',
            prefixIcon: error == PasswordValidationError.weak
                ? GestureDetector(
                    onTap: () => showModalBottomSheet(
                      context: context,
                      showDragHandle: true,
                      builder: (context) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          l10n.passwordTextFieldWeakPasswordErrorDescription,
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
            prefixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            suffixIcon: GestureDetector(
              onTap: () =>
                  setState(() => isPasswordVisible = !isPasswordVisible),
              child: Icon(
                isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                size: 25,
              ),
            ),
            errorText: error == PasswordValidationError.empty
                ? l10n.requiredFieldErrorMessage
                : error == PasswordValidationError.weak
                    ? l10n.newPasswordTextFieldWeakPasswordError
                    : null,
            hintText: l10n.newPasswordTextFieldHint,
          ),
          onChanged: cubit.onNewPasswordChanged,
          enabled: !isSubmissionInProgress,
        );
      },
    );
  }
}
