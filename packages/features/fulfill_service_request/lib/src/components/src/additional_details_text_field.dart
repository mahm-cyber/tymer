// import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:fulfill_service_request/fulfill_service_request.dart';
import 'package:fulfill_service_request/src/fulfill_service_request_cubit.dart';

class AdditionalDetailsTextField extends StatelessWidget {
  const AdditionalDetailsTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FulfillServiceRequestCubit, FulfillServiceRequestState>(
      builder: (context, state) {
        final cubit = context.read<FulfillServiceRequestCubit>();
        final l10n = FulfillServiceRequestLocalizations.of(context);
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        // final theme = TymerTheme.of(context);
        return TextField(
          controller: state.service?.response?.additionalNotes != null
              ? TextEditingController(
                  text: state.service?.response?.additionalNotes,
                )
              : null,
          textAlignVertical: TextAlignVertical.top,
          enabled: !isSubmissionInProgress,
          onChanged: cubit.onAdditionalDetailsChanged,
          maxLines: 5,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            labelText: l10n.additionalDetailsTextFieldLabel,
            hintText: l10n.additionalDetailsTextFieldLabel,
          ),
        );
      },
    );
  }
}
