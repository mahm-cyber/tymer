import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

import 'package:user_repository/user_repository.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit({
    required this.userRepository,
  }) : super(
          const ResetPasswordState(),
        );

  final UserRepository userRepository;

  void togglePasswordInfoOverlay(double yOffset) {
    final overLayToggled = state.copyWith(
      passwordInfoOverlayShown: !state.passwordInfoOverlayShown,
      passwordInfoOverlayYOffset: yOffset,
    );
    emit(overLayToggled);
  }

  void hidePasswordFormatInfoOverlay() {
    if (state.passwordInfoOverlayShown == true) {
      togglePasswordInfoOverlay(
        state.passwordInfoOverlayYOffset,
      );
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

  void onNewPasswordFocused() {
    hidePasswordFormatInfoOverlay();
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

  void onNewPasswordConfirmationFocused() {
    hidePasswordFormatInfoOverlay();
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
    final newPassword = Password.validated(
      state.newPassword.value,
      shouldCheckStrength: true,
    );
    final newPasswordConfirmation = PasswordConfirmation.validated(
      password: newPassword,
      state.newPasswordConfirmation.value,
    );

    final isFormValid = Formz.validate([
      newPassword,
      newPasswordConfirmation,
    ]);

    final newState = state.copyWith(
      newPassword: newPassword,
      newPasswordConfirmation: newPasswordConfirmation,
      submissionStatus: isFormValid ? FormzSubmissionStatus.inProgress : null,
    );

    emit(newState);

    if (isFormValid) {
      try {
        await userRepository.resetPassword(
          newPassword: newPassword.value!,
        );
        final newState = state.copyWith(
          submissionStatus: FormzSubmissionStatus.success,
        );
        emit(newState);
      } catch (error) {
        final newState = state.copyWith(
          submissionStatus: error is! WrongPasswordException
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
//   @override
//   Future<void> onChange(change) async {
//     print('+++++++${change.currentState.email}');
//     print('-------${change.nextState.email}');
//     super.onChange(change);
//   }
}
