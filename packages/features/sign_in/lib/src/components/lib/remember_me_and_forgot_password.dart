import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:sign_in/src/l10n/sign_in_localizations.dart';
import 'package:sign_in/src/sign_in_cubit.dart';

class RememberMeAndForgotPassword extends StatelessWidget {
  const RememberMeAndForgotPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final cubit = context.read<SignInCubit>();
    final l10n = SignInLocalizations.of(context);
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        return GestureDetector(
          onTap: isSubmissionInProgress
              ? null
              : () => cubit.rememberMeEmitter(
                    !state.shouldRememberCredentials,
                  ),
          child: Row(
            children: [
              SizedBox(
                height: 24,
                width: 24,
                child: Checkbox(
                  value: state.shouldRememberCredentials,
                  onChanged: isSubmissionInProgress
                      ? null
                      : (_) {
                          cubit.rememberMeEmitter(
                            !state.shouldRememberCredentials,
                          );
                        },
                ),
              ),
              HorizontalGap.xSmall(),
              Text(
                l10n.rememberMeCheckBoxLabel,
                style: textTheme.titleSmall,
              ),
              const Spacer(),
              TextButton(
                onPressed: isSubmissionInProgress
                    ? null
                    : () => cubit.onForgotPasswordTapped(),
                child: Text(
                  l10n.forgotMyPasswordButtonLabel,
                  style: textTheme.titleSmall,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
