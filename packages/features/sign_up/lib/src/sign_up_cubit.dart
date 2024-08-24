import 'dart:async';

import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

import 'package:intl/intl.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({
    required this.userRepository,
  }) : super(
          const SignUpState(),
        ) {
    scrollController.addListener(() {
      hidePasswordFormatInfoOverlay();
      final newScrollDirection = state.copyWith(
        scrollDirection: scrollController.position.userScrollDirection,
      );
      emit(newScrollDirection);
    });
  }

  final UserRepository userRepository;
  final scrollController = ScrollController();

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

  void scrollToShowNextTextField({double offset = 120}) {
    scrollController.animateTo(
      scrollController.offset + offset,
      duration: const Duration(milliseconds: 100),
      curve: Curves.bounceInOut,
    );
  }

  void onNameChanged(String newValue) {
    final previousScreenState = state;
    final previousNameState = previousScreenState.name;
    final shouldValidate = previousNameState.isNotValid;
    final newNameState = shouldValidate
        ? Name.validated(
            newValue,
          )
        : Name.unvalidated(
            newValue,
          );

    final newScreenState = state.copyWith(
      name: newNameState,
    );

    emit(newScreenState);
  }

  void onNameUnfocused() {
    final newScreenState = state.copyWith(
      name: Name.validated(
        state.name.value,
      ),
    );
    emit(newScreenState);
  }

  void onNameFocused() {
    hidePasswordFormatInfoOverlay();
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

  void onPhoneFocused() {
    hidePasswordFormatInfoOverlay();
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

  void onPasswordFocused() {
    hidePasswordFormatInfoOverlay();
    scrollToShowNextTextField();
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

  void onPasswordConfirmationFocused() {
    hidePasswordFormatInfoOverlay();
    scrollToShowNextTextField();
  }

  void onEmailChanged(String? newValue) {
    final previousEmail = state.email;
    final shouldValidate = previousEmail.isNotValid;
    final newState = state.copyWith(
      email: shouldValidate
          ? Email.validated(
              newValue,
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
      ),
    );

    emit(newState);
  }

  void onEmailFocused() {
    hidePasswordFormatInfoOverlay();
    scrollToShowNextTextField(offset: 250);
  }

  Future pickBirthdate(DateTime? dateTime) async {
    if (dateTime != null) {
      final date = DateFormat('yyyy-MM-dd').format(dateTime);
      onBirthDateTextFieldChanged(date);
    }
  }

  void onBirthDateTextFieldChanged(String newValue) {
    final previousBirthDate = state.birthdate;
    final shouldValidate = previousBirthDate.isNotValid;
    final newState = state.copyWith(
      birthdate: shouldValidate
          ? Birthdate.validated(
              newValue,
            )
          : Birthdate.unvalidated(
              newValue,
            ),
    );
    emit(newState);
  }

  void onBirthdateFocused() {
    hidePasswordFormatInfoOverlay();
    scrollToShowNextTextField(offset: 230);
  }

  void onCityChanged(CityDM? newValue) {
    final previousCity = state.city;
    final shouldValidate = previousCity.isNotValid;
    final newState = state.copyWith(
      city: shouldValidate
          ? City.validated(
              newValue,
            )
          : City.unvalidated(
              newValue,
            ),
    );
    emit(newState);
  }

  void onGenderTagChanged(GenderDM? gender) {
    final tagSelected = state.copyWith(
      gender: Gender.validated(gender),
    );
    emit(tagSelected);
  }

  void onSubmit() async {
    final name = Name.validated(
      state.name.value,
    );

    final phone = Mobile.validated(
      state.phone.value,
    );
    final password = Password.validated(state.password.value);

    final passwordConfirmation = PasswordConfirmation.validated(
      password: password,
      state.passwordConfirmation.value,
    );

    final email = Email.validated(state.email.value);

    final birthdate = Birthdate.validated(state.birthdate.value);

    final city = City.validated(state.city.value);

    final gender = Gender.validated(state.gender.value);

    final isFormValid = Formz.validate([
      name,
      phone,
      password,
      passwordConfirmation,
      email,
      birthdate,
      city,
      gender,
    ]);

    final newState = state.copyWith(
      name: name,
      phone: phone,
      password: password,
      passwordConfirmation: passwordConfirmation,
      email: email,
      birthdate: birthdate,
      city: city,
      gender: gender,
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
          name: name.value,
          city: city.value!.nameEn,
          birthdate: birthdate.value,
          gender: gender.value!,
        );
        // TODO: clean the full voucher and vendor profile history so the favourites are updated when the user visits a full voucher or vendor
        await userRepository.sendOtp(phone.value!);
        userRepository.changeNotifier.setOtpVerification(
          OtpVerification(
            phone: phone.value!,
            reason: OtpVerificationReason.register,
          ),
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
                error is EmailOrPhoneAlreadyRegisteredException ? true : false,
          ),
          phone: Mobile.validated(
            phone.value,
            isAlreadyRegistered:
                error is EmailOrPhoneAlreadyRegisteredException ? true : false,
          ),
          submissionStatus: error is! EmailOrPhoneAlreadyRegisteredException &&
                  error is! InvalidEmailFormatException
              ? FormzSubmissionStatus.failure
              : FormzSubmissionStatus.initial,
        );
        emit(newState);
        if (error is EmailOrPhoneAlreadyRegisteredException) {
          scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 100),
            curve: Curves.bounceInOut,
          );
        }
      }
    }
  }

  @override
  Future<void> close() async {
    scrollController.dispose();
    return super.close();
  }

// @override
// Future<void> onChange(change) async {
//   debugPrint('+++++++${change.currentState.name.value}');
//   debugPrint('-------${change.nextState.name.value}');
//   super.onChange(change);
// }
}
