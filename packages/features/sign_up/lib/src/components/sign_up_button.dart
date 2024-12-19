import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:sign_up/src/l10n/sign_up_localizations.dart';

import 'package:sign_up/src/sign_up_cubit.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final cubit = context.read<SignUpCubit>();
        // final theme = TymerTheme.of(context);
        final l10n = SignUpLocalizations.of(context);
        return isSubmissionInProgress
            ? TymerElevatedButton.inProgress(
                label: l10n.signUpInProgressButtonLabel,
              )
            : TymerElevatedButton(
                onTap: cubit.onSubmit,
                label: l10n.signUpButtonLabel,
              );
      },
    );
  }
}
