import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

import 'package:user_repository/user_repository.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit({
    required this.userRepository,
  }) : super(
          const ChangePasswordState(),
        );

  final UserRepository userRepository;

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
    final newScreenState = state.copyWith(
      password: Password.validated(
        state.password.value,
        invalidCredentials: state.password.invalidCredentials,
        shouldCheckStrength: false,
      ),
    );
    emit(newScreenState);
  }

  void onNewPasswordChanged(String? newValue) {
    final previousScreenState = state;
    final previousNewPasswordState = previousScreenState.newPassword;
    final shouldValidate = previousNewPasswordState.isNotValid;
    final newPasswordState = shouldValidate
        ? Password.validated(
            newValue,
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
      ),
    );
    emit(newScreenState);
  }

  void onNewPasswordConfirmationChanged(String newValue) {
    final previousNewPasswordConfirmation = state.newPasswordConfirmation;
    final shouldValidate = previousNewPasswordConfirmation.isNotValid;
    final newState = state.copyWith(
      newPasswordConfirmation: shouldValidate
          ? PasswordConfirmation.validated(
              newValue,
              password: state.newPassword,
            )
          : PasswordConfirmation.unvalidated(
              newValue,
            ),
    );
    emit(newState);
  }

  void onNewPasswordConfirmationUnfocused() {
    final newState = state.copyWith(
      newPasswordConfirmation: PasswordConfirmation.validated(
        state.newPasswordConfirmation.value,
        password: state.newPassword,
      ),
    );
    emit(newState);
  }

  void onSubmit() async {
    final password = Password.validated(
      state.password.value,
      shouldCheckStrength: false,
    );

    final newPassword = Password.validated(
      state.newPassword.value,
    );

    final newPasswordConfirmation = PasswordConfirmation.validated(
      password: newPassword,
      state.newPasswordConfirmation.value,
    );

    final isFormValid = Formz.validate([
      password,
      newPassword,
      newPasswordConfirmation,
    ]);

    final newState = state.copyWith(
      password: password,
      newPassword: newPassword,
      newPasswordConfirmation: newPasswordConfirmation,
      submissionStatus: isFormValid
          ? FormzSubmissionStatus.inProgress
          : FormzSubmissionStatus.initial,
    );

    emit(newState);

    if (isFormValid) {
      try {
        await userRepository.changePassword(
          password: password.value!,
          newPassword: newPassword.value!,
          newPasswordConfirmation: newPasswordConfirmation.value,
        );
        final newState = state.copyWith(
          submissionStatus: FormzSubmissionStatus.success,
        );
        emit(newState);
      } catch (error) {
        final newState = state.copyWith(
          password: Password.validated(
            password.value,
            shouldCheckStrength: false,
            invalidCredentials:
                error is IncorrectPasswordException ? true : false,
          ),
          newPassword: Password.validated(
            newPassword.value,
          ),
          newPasswordConfirmation: PasswordConfirmation.validated(
            state.newPasswordConfirmation.value,
            password: newPassword,
          ),
          submissionStatus: error is! IncorrectPasswordException
              ? FormzSubmissionStatus.failure
              : FormzSubmissionStatus.initial,
        );
        emit(newState);
      }
    }
  }

// @override
// Future<void> close() async {
//   return super.close();
// }

// @override
// Future<void> onChange(change) async {
//   debugPrint('+++++++${change.currentState.name.value}');
//   debugPrint('-------${change.nextState.name.value}');
//   super.onChange(change);
// }
}
