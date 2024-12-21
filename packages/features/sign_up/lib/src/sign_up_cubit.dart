import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

import 'package:user_repository/user_repository.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({
    required this.userRepository,
  }) : super(
          const SignUpState(),
        );

  final UserRepository userRepository;

  void onNameChanged(String newValue) {
    final previousScreenState = state;
    final previousNameState = previousScreenState.name;
    final shouldValidate = previousNameState.isNotValid;
    final newNameState = shouldValidate
        ? Dynamic<String?>.validated(
            newValue,
            isRequired: true,
          )
        : Dynamic<String?>.unvalidated(
            newValue,
          );

    final newScreenState = state.copyWith(
      name: newNameState,
    );

    emit(newScreenState);
  }

  void onNameUnfocused() {
    final newScreenState = state.copyWith(
      name: Dynamic<String?>.validated(
        state.name.value,
        isRequired: true,
      ),
    );
    emit(newScreenState);
  }

  void onPhoneChanged(String newValue) {
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

  void onPhoneUnfocused() {
    final newScreenState = state.copyWith(
      phone: Mobile.validated(
        state.phone.value,
        isAlreadyRegistered: state.phone.isAlreadyRegistered,
      ),
    );
    emit(newScreenState);
  }

  void onPasswordChanged(String? newValue) {
    final previousScreenState = state;
    final previousPasswordState = previousScreenState.password;
    final shouldValidate = previousPasswordState.isNotValid;
    final newPasswordState = shouldValidate
        ? Password.validated(
            newValue,
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
      ),
    );
    emit(newScreenState);
  }

  void onPasswordConfirmationChanged(String newValue) {
    final previousPasswordConfirmation = state.passwordConfirmation;
    final shouldValidate = previousPasswordConfirmation.isNotValid;
    final newState = state.copyWith(
      passwordConfirmation: shouldValidate
          ? PasswordConfirmation.validated(
              newValue,
              password: state.password,
            )
          : PasswordConfirmation.unvalidated(
              newValue,
            ),
    );
    emit(newState);
  }

  void onPasswordConfirmationUnfocused() {
    final newState = state.copyWith(
      passwordConfirmation: PasswordConfirmation.validated(
        state.passwordConfirmation.value,
        password: state.password,
      ),
    );
    emit(newState);
  }

  void onEmailChanged(String? newValue) {
    final previousEmail = state.email;
    final shouldValidate = previousEmail.isNotValid;
    final newState = state.copyWith(
      email: shouldValidate
          ? Email.validated(
              newValue,
              isRequired: true,
            )
          : Email.unvalidated(
              newValue,
            ),
    );
    emit(newState);
  }

  void onEmailUnfocused() {
    final newState = state.copyWith(
      email: Email.validated(
        state.email.value,
        invalidCredentials: state.email.invalidCredentials,
        invalidFormat: state.email.invalidFormat,
        isAlreadyRegistered: state.email.isAlreadyRegistered,
        isRequired: true,
      ),
    );

    emit(newState);
  }

  void onTermsAndConditionsChanged(bool newValue) {
    final previousTermsAndConditions = state.termsAndConditionsAccepted;
    final shouldValidate = previousTermsAndConditions.isNotValid;
    final newState = state.copyWith(
      termsAndConditionsAccepted: shouldValidate
          ? Dynamic.validated(
              newValue == false ? null : true,
            )
          : Dynamic.unvalidated(
              newValue == false ? null : true,
            ),
    );
    emit(newState);
  }

  void getAndShowTermsAndConditions() async {
    final newState = state.copyWith(
      termsAndConditionsFetchStatus: FetchStatus.loading,
    );
    emit(newState);
    try {
      final settings =
          await userRepository.getSettings(FetchPolicy.cachePreferably);
      final termsAndConditions = settings.termsAndConditions;
      final newState = state.copyWith(
        termsAndConditions: termsAndConditions,
        termsAndConditionsFetchStatus: FetchStatus.success,
      );
      emit(newState);
    } catch (error) {
      final newState = state.copyWith(
        termsAndConditionsFetchStatus: FetchStatus.failure,
      );
      emit(newState);
    }
  }

  void onSubmit() async {
    final name = Dynamic<String?>.validated(
      state.name.value,
      isRequired: true,
    );

    final phone = Mobile.validated(
      state.phone.value,
    );
    final password = Password.validated(state.password.value);

    final passwordConfirmation = PasswordConfirmation.validated(
      password: password,
      state.passwordConfirmation.value,
    );

    final email = Email.validated(
      state.email.value,
      isRequired: true,
    );
    final termsAndConditionsAccepted = Dynamic<bool>.validated(
      state.termsAndConditionsAccepted.value,
      isRequired: true,
    );
    final isFormValid = Formz.validate([
      name,
      phone,
      password,
      passwordConfirmation,
      email,
      termsAndConditionsAccepted
    ]);

    final newState = state.copyWith(
      name: name,
      phone: phone,
      password: password,
      passwordConfirmation: passwordConfirmation,
      email: email,
      termsAndConditionsAccepted: termsAndConditionsAccepted,
      submissionStatus: isFormValid
          ? FormzSubmissionStatus.inProgress
          : FormzSubmissionStatus.initial,
    );

    emit(newState);

    if (isFormValid) {
      try {
        await userRepository.signUp(
          email: email.value!,
          password: password.value!,
          phone: phone.value!,
          name: name.value!,
          passwordConfirmation: passwordConfirmation.value,
        );
        final newState = state.copyWith(
          submissionStatus: FormzSubmissionStatus.success,
        );
        emit(newState);
      } catch (error) {
        final newState = state.copyWith(
          password: Password.validated(
            password.value,
          ),
          email: Email.validated(
            email.value,
            invalidFormat: error is InvalidEmailFormatException ? true : false,
            isAlreadyRegistered:
                error is EmailAlreadyRegisteredException ? true : false,
            isRequired: true,
          ),
          phone: Mobile.validated(
            phone.value,
            isAlreadyRegistered:
                error is PhoneAlreadyRegisteredException ? true : false,
          ),
          submissionStatus: error is! EmailAlreadyRegisteredException &&
                  error is! PhoneAlreadyRegisteredException &&
                  error is! InvalidEmailFormatException
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
