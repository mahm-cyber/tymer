import 'dart:async';

import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({
    required this.userRepository,
    required this.onUnverifiedSignIn,
    required this.onSignUpTapped,
    required this.onForgotPasswordTapped,
  }) : super(
          const SignInState(),
        ) {
    // getAppDependencies();
    getRememberMeFromCache().then(
      (_) async {
        onPhoneChanged(state.rememberMe.phone);
        onPasswordChanged(state.rememberMe.password);
        if (state.rememberMe.phone != null) {
          emit(state.copyWith(shouldRememberCredentials: true));
        }
      },
    );
  }

  final UserRepository userRepository;
  final VoidCallback onUnverifiedSignIn;
  final VoidCallback onSignUpTapped;
  final VoidCallback onForgotPasswordTapped;

  void onPhoneChanged(String? newValue) {
    final previousEmail = state.phone;
    final shouldValidate = previousEmail.isNotValid;
    final newState = state.copyWith(
      phone: shouldValidate
          ? Mobile.validated(
              newValue,
              invalidCredentials: state.phone.invalidCredentials,
              unVerified: state.phone.unVerified,
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
        invalidCredentials: state.phone.invalidCredentials,
        unVerified: state.phone.unVerified,
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

  void rememberMeEmitter(bool shouldRememberCredentials) {
    emit(state.copyWith(shouldRememberCredentials: shouldRememberCredentials));
  }


  Future getRememberMeFromCache() async {
    final rememberMeLoading = state.copyWith(rememberMeLoading: true);
    emit(rememberMeLoading);

    final rememberMe = await userRepository.getRememberedCredentials();
    emit(state.copyWith(rememberMe: rememberMe));

    final rememberMeLoadingDone = state.copyWith(rememberMeLoading: false);
    emit(rememberMeLoadingDone);
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
        await userRepository.signIn(
          phone: phone.value!,
          password: password.value!,
        );
        if (state.shouldRememberCredentials) {
          await userRepository.cacheRememberedCredentials(
            phone: phone.value!,
            password: password.value!,
          );
        } else {
          await userRepository.deleteRememberedCredentials();
        }
        final newState = state.copyWith(
          submissionStatus: FormzSubmissionStatus.success,
        );
        emit(newState);
        if (state.shouldRememberCredentials) {
          await userRepository.cacheRememberedCredentials(
            phone: phone.value!,
            password: password.value!,
          );
        }
      } catch (error) {
        final newState = state.copyWith(
          password: Password.validated(password.value,
              invalidCredentials:
              error is InvalidCredentialsException ? true : false,
              shouldCheckStrength: false),
          phone: Mobile.validated(
            phone.value,
            invalidCredentials:
            error is InvalidCredentialsException ? true : false,
            unVerified: error is PhoneNotVerifiedException ? true : false,
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
