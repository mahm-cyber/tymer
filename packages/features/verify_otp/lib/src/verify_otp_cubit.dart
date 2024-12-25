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
    required this.onResetPasswordVerifyOtpSuccess,
    required this.onRegistrationVerifyOtpSuccess,
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
  final VoidCallback onResetPasswordVerifyOtpSuccess;
  final VoidCallback onRegistrationVerifyOtpSuccess;
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
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final newResendOtpTimer = state.resendOtpSecondTimer == 0
          ? 59.00
          : (state.resendOtpSecondTimer - 1);
      final newResendTotalTime = state.resendOtpTotalTime - 1;
      if (newResendTotalTime == 0) {
        timer.cancel();
      }
      emit(state.copyWith(
        resendOtpTotalTime: newResendTotalTime,
        resendOtpSecondTimer: newResendOtpTimer,
      ));
    });
  }

  Future resendOtp() async {
    // Logic to resend the OTP
    // await userRepository.reSendOtp();
    final resendOtpInProgress = state.copyWith(
      resendOtpStatus: ResendOtpStatus.inProgress,
      submissionStatus: FormzSubmissionStatus.initial,
    );
    emit(resendOtpInProgress);
    try {
      await userRepository.reSendOtp();
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
        error: error,
      );
      emit(resendOtpError);
    }
  }

  void onNewPasswordChanged(String newValue) {
    final previousScreenState = state;
    final previousPasswordState = previousScreenState.newPassword;
    final shouldValidate = previousPasswordState.isNotValid;
    final newPasswordState = shouldValidate
        ? Password.validated(
            newValue,
            shouldCheckStrength: true,
          )
        : Password.unvalidated(
            newValue,
          );

    final newScreenState = state.copyWith(
      newPassword: newPasswordState,
    );

    emit(newScreenState);
  }

  void onNewPasswordUnfocused() {
    final newScreenState = state.copyWith(
      newPassword: Password.validated(
        state.newPassword.value,
        shouldCheckStrength: true,
      ),
    );
    emit(newScreenState);
  }

  void onNewPasswordConfirmationChanged(String newValue) {
    final previousScreenState = state;
    final previousPasswordState = previousScreenState.newPasswordConfirmation;
    final shouldValidate = previousPasswordState.isNotValid;
    final newPasswordConfirmation = shouldValidate
        ? PasswordConfirmation.validated(
            password: state.newPassword,
            newValue,
          )
        : PasswordConfirmation.unvalidated(
            newValue,
          );

    final newScreenState = state.copyWith(
      newPasswordConfirmation: newPasswordConfirmation,
    );

    emit(newScreenState);
  }

  void onNewPasswordConfirmationUnfocused() {
    final newScreenState = state.copyWith(
      newPasswordConfirmation: PasswordConfirmation.validated(
        password: state.newPassword,
        state.newPasswordConfirmation.value,
      ),
    );
    emit(newScreenState);
  }

  void onSubmit() async {
    final otpCode = OtpCode.validated(state.otpCode.value);
    final newPassword = Password.validated(
      state.newPassword.value,
      shouldCheckStrength: true,
    );
    final newPasswordConfirmation = PasswordConfirmation.validated(
      password: newPassword,
      state.newPasswordConfirmation.value,
    );

    final isVerificationReasonForgotPassword =
        state.otpVerification?.reason == OtpVerificationReason.forgotPassword;
    final isVerificationReasonRegister =
        state.otpVerification?.reason == OtpVerificationReason.register;
    final isVerificationReasonChangePhone =
        state.otpVerification?.reason == OtpVerificationReason.changePhone;
    final isFormValid = Formz.validate([
      otpCode,
      if (isVerificationReasonForgotPassword) ...[
        newPassword,
        newPasswordConfirmation,
      ],
    ]);

    final newState = state.copyWith(
      otpCode: otpCode,
      newPassword: newPassword,
      newPasswordConfirmation: newPasswordConfirmation,
      submissionStatus: isFormValid
          ? FormzSubmissionStatus.inProgress
          : FormzSubmissionStatus.initial,
      resendOtpStatus: ResendOtpStatus.initial,
    );

    emit(newState);

    if (isFormValid) {
      try {
        if (isVerificationReasonForgotPassword) {
          await userRepository.verifyOtpForPasswordReset(
            otp: otpCode.value,
            newPassword: newPassword.value!,
            newPasswordConfirmation: newPassword.value!,
          );
        } else if (isVerificationReasonRegister) {
          await userRepository.verifyOtpForRegistration(
            otpCode.value,
          );
          await userRepository.signIn(
            phone: state.otpVerification!.phone,
            password: state.otpVerification!.password!,
          );
        } else if (isVerificationReasonChangePhone) {
          await userRepository.verifyOtpForChangePhone(
            otpCode.value,
          );
        }

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
            limitExceeded:
                error is OtpRateLimitExceededException ? error : null,
          ),
          newPassword: Password.validated(
            newPassword.value,
            shouldCheckStrength: true,
          ),
          newPasswordConfirmation: PasswordConfirmation.validated(
            password: newPassword,
            newPasswordConfirmation.value,
          ),
          submissionStatus: error is! InvalidOtpException &&
                  error is! OtpRateLimitExceededException && error is! PhoneAlreadyRegisteredException
              ? FormzSubmissionStatus.failure
              : FormzSubmissionStatus.initial,
          resendOtpStatus: ResendOtpStatus.initial,
          error: error,
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
