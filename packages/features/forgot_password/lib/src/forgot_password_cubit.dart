import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

import 'package:user_repository/user_repository.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit({
    required this.userRepository,
  }) : super(
          const ForgotPasswordState(),
        );

  final UserRepository userRepository;

  void onMobileChanged(String newValue) {
    final previousScreenState = state;
    final previousPhoneState = previousScreenState.phone;
    final shouldValidate = previousPhoneState.isNotValid;
    final newPhoneState = shouldValidate
        ? Mobile.validated(
            newValue,
          )
        : Mobile.unvalidated(
            newValue,
          );

    final newScreenState = state.copyWith(
      phone: newPhoneState,
    );

    emit(newScreenState);
  }

  void onMobileUnfocused() {
    final newScreenState = state.copyWith(
      phone: Mobile.validated(
        state.phone.value,
        isNotRegistered: state.phone.isNotRegistered,
      ),
    );
    emit(newScreenState);
  }

  void onSubmit() async {
    final phone = Mobile.validated(
      state.phone.value,
    );

    final isFormValid = Formz.validate([
      phone,
    ]);

    final newState = state.copyWith(
      phone: phone,
      submissionStatus: isFormValid
          ? FormzSubmissionStatus.inProgress
          : FormzSubmissionStatus.initial,
    );

    emit(newState);

    if (isFormValid) {
      try {
        await userRepository.requestOtpForForgotPassword(
          phone: phone.value!,
        );

        final newState = state.copyWith(
          submissionStatus: FormzSubmissionStatus.success,
        );
        emit(newState);
      } catch (error) {
        final newState = state.copyWith(
          phone: Mobile.validated(
            phone.value,
            isNotRegistered:
                error is PhoneNotRegisteredException ? true : false,
          ),
          submissionStatus: error is! PhoneNotRegisteredException
              ? FormzSubmissionStatus.failure
              : FormzSubmissionStatus.initial,
          error: error,
        );
        emit(newState);
      }
    }
  }
}
