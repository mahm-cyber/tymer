import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:change_phone/src/l10n/change_phone_localizations.dart';

import 'package:change_phone/src/change_phone_cubit.dart';

class ChangePhoneButton extends StatelessWidget {
  const ChangePhoneButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePhoneCubit, ChangePhoneState>(
      builder: (context, state) {
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final cubit = context.read<ChangePhoneCubit>();
        final l10n = ChangePhoneLocalizations.of(context);
        return isSubmissionInProgress
            ? TymerElevatedButton.inProgress(
                label: l10n.changePhoneInProgressButtonLabel,
              )
            : TymerElevatedButton(
                onTap: cubit.onSubmit,
                label: l10n.changePhoneButtonLabel,
              );
      },
    );
  }
}
