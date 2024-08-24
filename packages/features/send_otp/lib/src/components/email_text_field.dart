import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:send_otp/src/l10n/send_otp_localizations.dart';
import 'package:send_otp/src/send_otp_cubit.dart';

class EmailTextField extends StatefulWidget {
  const EmailTextField({
    super.key,
  });

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  final _emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _setUpEmailFieldFocusListener();
  }

  void _setUpEmailFieldFocusListener() {
    final cubit = context.read<SendOtpCubit>();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        cubit.onEmailUnfocused();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendOtpCubit, SendOtpState>(builder: (context, state) {
      final cubit = context.read<SendOtpCubit>();
      final emailError = state.email.isNotValid ? state.email.error : null;
      final isSubmissionInProgress =
          state.submissionStatus == FormzSubmissionStatus.inProgress;
      final theme = TymerTheme.of(context);
      final textTheme = Theme.of(context).textTheme;
      final l10n = SendOtpLocalizations.of(context);

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.emailTextFieldLabel,
              style:
                  textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            VerticalGap.medium(),
            TextFormField(
              enabled: !isSubmissionInProgress,
              focusNode: _emailFocusNode,
              onChanged: cubit.onEmailChanged,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: Spacing.small,
                  vertical: Spacing.small,
                ),
                isDense: true,
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 40,
                  minHeight: 0,
                ),
                prefixIcon: const Icon(
                  Icons.email_outlined,
                ),
                hintText: l10n.emailTextFieldLabel,
                errorText: emailError == EmailValidationError.empty
                    ? l10n.requiredFieldErrorMessage
                    : emailError == EmailValidationError.invalidCredentials
                        ? l10n.invalidCredentialsErrorMessage
                        : emailError == EmailValidationError.invalidFormat
                            ? l10n.invalidEmailFormatErrorMessage
                            : null,
              ),
            ),
          ],
        ),
      );
    });
  }
}
