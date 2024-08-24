import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

import 'package:send_otp/src/send_otp_cubit.dart';

class Phone extends StatefulWidget {
  const Phone({
    super.key,
  });

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<SendOtpCubit>();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        cubit.onEmailUnfocused();
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
    return BlocBuilder<SendOtpCubit, SendOtpState>(
      builder: (context, state) {
        // final error = state.email.isNotValid ? state.email.error : null;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        // final theme = TymerkTheme.of(context);

        return TextField(
          focusNode: _focusNode,
          onChanged: context.read<SendOtpCubit>().onEmailChanged,
          enabled: !isSubmissionInProgress,
        );
      },
    );
  }
}
