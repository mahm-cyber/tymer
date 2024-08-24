import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:sign_in/src/l10n/sign_in_localizations.dart';

import 'package:sign_in/src/sign_in_cubit.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final cubit = context.read<SignInCubit>();
        final theme = TymerTheme.of(context);
        final l10n = SignInLocalizations.of(context);
        return Container(
          padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
          decoration: BoxDecoration(
            boxShadow: isSubmissionInProgress
                ? null
                : [
                    const BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      offset: Offset(0, 4),
                      blurRadius: 26,
                    ),
                  ],
          ),
          child: isSubmissionInProgress
              ? TymerElevatedButton.inProgress(
                  label: l10n.signInInProgressButtonLabel,
                )
              : TymerElevatedButton(
                  onTap: cubit.onSubmit,
                  label: l10n.signInButtonLabel,
                ),
        );
      },
    );
  }
}
