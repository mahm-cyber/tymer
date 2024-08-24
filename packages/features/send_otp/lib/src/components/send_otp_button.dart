import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

import 'package:send_otp/src/send_otp_cubit.dart';

class SendOtpButton extends StatelessWidget {
  const SendOtpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendOtpCubit, SendOtpState>(
      builder: (context, state) {
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final cubit = context.read<SendOtpCubit>();
        // final theme = TymerkTheme.of(context);

        return isSubmissionInProgress
            ? TymerElevatedButton.inProgress(
                label: 'جارى الارسال',
              )
            : TymerElevatedButton(
                onTap: cubit.onSubmit,
                label: 'ارسال',
              );
      },
    );
  }
}
