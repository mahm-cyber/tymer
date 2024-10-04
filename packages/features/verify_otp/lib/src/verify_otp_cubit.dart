import 'dart:async';
import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

import 'package:user_repository/user_repository.dart';

part 'verify_otp_state.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  VerifyOtpCubit({
    required this.userRepository,
  })  : pinTEController = TextEditingController(),
        super(
          VerifyOtpState(
            otpVerification: userRepository.changeNotifier.otpVerification,
          ),
        ) {
    startTimer();
  }

  Timer? _timer;
  final UserRepository userRepository;
  final TextEditingController pinTEController;

  onOtpCodeChanged(String newValue) {
    final newOtpCode = OtpCode.unvalidated(
      newValue,
    );

    final newState = state.copyWith(
      otpCode: newOtpCode,
      submissionStatus: FormzSubmissionStatus.initial,
      resendOtpStatus: ResendOtpStatus.initial,
    );
    emit(newState);
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final newResendOtpTimer = state.resendOtpSecondTimer == 0
          ? 59.00
          : (state.resendOtpSecondTimer - 1);
      final newResendTotalTime = state.resendOtpTotalTime - 1;
      if (newResendTotalTime == 0) {
        timer.cancel();
      }
      emit(state.copyWith(
        resendOtpTotalTime: newResendTotalTime,
        resendOtpTimer: newResendOtpTimer,
      ));
    });
  }

  Future resendOtp() async {
    // Logic to resend the OTP
    await userRepository.sendOtp();
    final resendOtpInProgress = state.copyWith(
      resendOtpStatus: ResendOtpStatus.inProgress,
      submissionStatus: FormzSubmissionStatus.initial,
    );
    emit(resendOtpInProgress);
    try {
      await userRepository.sendOtp();
      final resendOtpSuccess = state.copyWith(
        submissionStatus: FormzSubmissionStatus.initial,
        resendOtpStatus: ResendOtpStatus.success,
        resendOtpTotalTime: 2 * 60,
      );
      emit(resendOtpSuccess);
      startTimer();
    } catch (error) {
      final resendOtpError = state.copyWith(
        submissionStatus: FormzSubmissionStatus.initial,
        resendOtpStatus: ResendOtpStatus.error,
      );
      emit(resendOtpError);
    }
  }

  void onSubmit() async {
    final otpCode = OtpCode.validated(state.otpCode.value);
    final isFormValid = Formz.validate([
      otpCode,
    ]);

    final newState = state.copyWith(
      otpCode: otpCode,
      submissionStatus: isFormValid
          ? FormzSubmissionStatus.inProgress
          : FormzSubmissionStatus.initial,
      resendOtpStatus: ResendOtpStatus.initial,
    );

    emit(newState);

    if (isFormValid) {
      try {
        await userRepository.verifyOtp(
          otpCode.value,
        );

        final newState = state.copyWith(
          otpCode: const OtpCode.unvalidated(),
          submissionStatus: FormzSubmissionStatus.success,
          resendOtpStatus: ResendOtpStatus.initial,
        );
        emit(newState);
        pinTEController.clear();
      } catch (error) {
        final newState = state.copyWith(
          otpCode: OtpCode.validated(
            otpCode.value,
            incorrectCode: error is InvalidOtpException ? true : false,
            limitCrossed: error is OtpRateLimitExceededException ? true : false,
          ),
          submissionStatus:
              error is! InvalidOtpException && error is! OtpRateLimitExceededException
                  ? FormzSubmissionStatus.failure
                  : FormzSubmissionStatus.initial,
          resendOtpStatus: ResendOtpStatus.initial,
        );
        emit(newState);
      }
    }
  }

  @override
  Future<void> close() async {
    pinTEController.dispose();
    _timer?.cancel();

    return super.close();
  }
}
