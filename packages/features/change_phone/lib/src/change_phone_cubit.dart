import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:user_repository/user_repository.dart';

part 'change_phone_state.dart';

class ChangePhoneCubit extends Cubit<ChangePhoneState> {
  ChangePhoneCubit({
    required this.userRepository,
  }) : super(
          const ChangePhoneState(),
        );

  final UserRepository userRepository;

  void onPhoneChanged(String? newValue) {
    final previousEmail = state.phone;
    final shouldValidate = previousEmail.isNotValid;
    final newState = state.copyWith(
      phone: shouldValidate
          ? Mobile.validated(
              newValue,
              invalidCredentials: state.phone.invalidCredentials,
            )
          : Mobile.unvalidated(
              newValue,
            ),
      password: Password.unvalidated(state.password.value),
    );
    emit(newState);
  }

  void onPhoneUnfocused() {
    final newState = state.copyWith(
      phone: Mobile.validated(
        state.phone.value,
      ),
    );

    emit(newState);
  }

  void onPasswordChanged(String? newValue) {
    final previousScreenState = state;
    final previousPasswordState = previousScreenState.password;
    final shouldValidate = previousPasswordState.isNotValid;
    final newPasswordState = shouldValidate
        ? Password.validated(
            newValue,
            shouldCheckStrength: false,
          )
        : Password.unvalidated(
            newValue,
          );

    final newScreenState = state.copyWith(
      password: newPasswordState,
    );

    emit(newScreenState);
  }

  void onPasswordUnfocused() {
    final previousScreenState = state;
    final previousPasswordState = previousScreenState.password;
    final previousPasswordValue = previousPasswordState.value;

    final newPasswordState = Password.validated(
      previousPasswordValue,
      shouldCheckStrength: false,
      invalidCredentials: state.password.invalidCredentials,
    );
    final newScreenState = previousScreenState.copyWith(
      password: newPasswordState,
    );
    emit(newScreenState);
  }

  void onSubmit() async {
    final phone = Mobile.validated(
      state.phone.value,
    );
    final password = Password.validated(
      state.password.value,
      shouldCheckStrength: false,
    );

    final isFormValid = Formz.validate([
      phone,
      password,
    ]);

    final newState = state.copyWith(
      phone: phone,
      password: password,
      submissionStatus: isFormValid
          ? FormzSubmissionStatus.inProgress
          : FormzSubmissionStatus.initial,
    );

    emit(newState);

    if (isFormValid) {
      try {
        await userRepository.requestOtpForChangePhone(
          phone: phone.value!,
          password: password.value!,
        );

        final newState = state.copyWith(
          submissionStatus: FormzSubmissionStatus.success,
        );
        emit(newState);
      } catch (error) {
        final newState = state.copyWith(
          password: Password.validated(
            password.value,
            invalidCredentials:
                error is IncorrectPasswordException ? true : false,
            shouldCheckStrength: false,
          ),
          phone: Mobile.validated(
            phone.value,
            isAlreadyRegistered: error is PhoneAlreadyRegisteredException ? true : false,
          ),
          submissionStatus: FormzSubmissionStatus.initial,
          error: error,
        );
        emit(newState);
      }
    }
  }

// @override
// Future<void> close() async {
//   return super.close();
// }
//   @override
//   Future<void> onChange(change) async {
//     print('+++++++${change.currentState.email}');
//     print('-------${change.nextState.email}');
//     super.onChange(change);
//   }
}
