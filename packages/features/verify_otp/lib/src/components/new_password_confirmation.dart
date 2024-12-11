import 'package:verify_otp/src/l10n/verify_otp_localizations.dart';
import 'package:verify_otp/src/verify_otp_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

class NewPasswordConfirmation extends StatefulWidget {
  const NewPasswordConfirmation({
    super.key,
  });

  @override
  State<NewPasswordConfirmation> createState() =>
      _NewPasswordConfirmationState();
}

class _NewPasswordConfirmationState extends State<NewPasswordConfirmation> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<VerifyOtpCubit>();
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

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifyOtpCubit, VerifyOtpState>(
      builder: (context, state) {
        final error = state.newPasswordConfirmation.isNotValid
            ? state.newPasswordConfirmation.error
            : null;
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

            suffixIcon: GestureDetector(
              onTap: () =>
                  setState(() => isPasswordVisible = !isPasswordVisible),
              child: Icon(
                isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                size: 25,
              ),
            ),
            hintText: l10n.newPasswordConfirmationTextFieldHint,
            errorText: error == PasswordConfirmationValidationError.empty
                ? l10n.requiredFieldErrorMessage
                : error == PasswordConfirmationValidationError.doesNotMatch
                    ? l10n.passwordConfirmationTextFieldDoesNotMatchError
                    : null,
          ),
          onChanged: cubit.onNewPasswordConfirmationChanged,
          enabled: !isSubmissionInProgress,
          onEditingComplete: cubit.onSubmit,
        );
      },
    );
  }
}
