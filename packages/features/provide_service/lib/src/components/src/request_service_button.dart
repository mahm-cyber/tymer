import 'package:form_fields/form_fields.dart';
import 'package:request_service/src/l10n/request_service_localizations.dart';
import 'package:request_service/src/request_service_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestServiceButton extends StatelessWidget {
  const RequestServiceButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestServiceCubit, RequestServiceState>(
      builder: (context, state) {
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final l10n = RequestServiceLocalizations.of(context);
        final cubit = context.read<RequestServiceCubit>();
        final theme = TymerTheme.of(context);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
          child: isSubmissionInProgress
              ? TymerElevatedButton.inProgress(
            label: l10n.requestServiceButtonInProgressLabel,
          )
              : TymerElevatedButton(
            label: l10n.requestServiceButtonLabel,
            onTap: cubit.onSubmit,
          ),
        );
      },
    );
  }
}
