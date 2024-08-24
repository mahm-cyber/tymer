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
    required this.otpVerification,
  })  : pinTEController = TextEditingController(),
        super(
          VerifyOtpState(otpVerification: otpVerification),
        );

  final UserRepository userRepository;
  final OtpVerification otpVerification;
  final TextEditingController pinTEController;

  onOtpCodeChanged(String newValue) {
    final newOtpCode = OtpCode.unvalidated(
      newValue,
    );

    final newState = state.copyWith(
      otpCode: newOtpCode,
      submissionStatus: FormzSubmissionStatus.initial,
    );
    emit(newState);
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
    );

    emit(newState);

    if (isFormValid) {
      final phone = userRepository.changeNotifier.otpVerification!.email;

      try {
        await userRepository.verifyOtp(
          phone,
          otpCode.value,
        );

        final newState = state.copyWith(
          otpCode: const OtpCode.unvalidated(),
          submissionStatus: FormzSubmissionStatus.success,
        );
        emit(newState);
      } catch (error) {
        final newState = state.copyWith(
          otpCode: OtpCode.validated(
            otpCode.value,
            incorrectCode: error is InvalidOtpException ? true : false,
          ),
          submissionStatus: error is! InvalidOtpException
              ? FormzSubmissionStatus.failure
              : FormzSubmissionStatus.initial,
        );
        emit(newState);
      }
    }
  }

  @override
  Future<void> close() async {
    pinTEController.dispose();
    return super.close();
  }
}
