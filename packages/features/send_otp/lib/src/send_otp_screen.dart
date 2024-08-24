import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:send_otp/src/components/phone.dart';
import 'package:send_otp/src/components/send_otp_button.dart';

import 'package:send_otp/src/send_otp_cubit.dart';
import 'package:user_repository/user_repository.dart';

class SendOtpScreen extends StatelessWidget {
  const SendOtpScreen({
    required this.userRepository,
    required this.onSendOtpSuccess,
    super.key,
  });

  final UserRepository userRepository;
  final VoidCallback onSendOtpSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SendOtpCubit>(
      create: (_) => SendOtpCubit(
        userRepository: userRepository,
      ),
      child: SendOtpView(
        onSendOtpSuccess: onSendOtpSuccess,
      ),
    );
  }
}

class SendOtpView extends StatelessWidget {
  const SendOtpView({
    super.key,
    required this.onSendOtpSuccess,
  });

  final VoidCallback onSendOtpSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendOtpCubit, SendOtpState>(
      listenWhen: (oldState, newState) =>
          oldState.submissionStatus != newState.submissionStatus,
      listener: (context, state) {
        if (state.submissionStatus == FormzSubmissionStatus.success) {
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              context: context,
              message: 'تم الارسال بنجاح',
            ),
          );
          onSendOtpSuccess();
          return;
        }
        if (state.submissionStatus == FormzSubmissionStatus.failure) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: 'حدث خطأ ما',
            ),
          );
          return;
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.releaseFocus();
          },
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                VerticalGap.large(),
                const Phone(),
                VerticalGap.xSmall(),
                const SendOtpButton(),
                VerticalGap.mediumLarge(),
              ],
            ),
          ),
        );
      },
    );
  }
}
