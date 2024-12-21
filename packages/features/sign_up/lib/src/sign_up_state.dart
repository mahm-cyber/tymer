part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.name = const Dynamic<String?>.unvalidated(),
    this.phone = const Mobile.unvalidated(),
    this.password = const Password.unvalidated(),
    this.termsAndConditionsAccepted = const Dynamic<bool>.unvalidated(),
    this.passwordConfirmation = const PasswordConfirmation.unvalidated(),
    this.email = const Email.unvalidated(),
    this.termsAndConditions,
    this.termsAndConditionsFetchStatus = FetchStatus.initial,
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final Dynamic<bool> termsAndConditionsAccepted;
  final Dynamic<String?> name;
  final Mobile phone;
  final Password password;
  final PasswordConfirmation passwordConfirmation;
  final Email email;
  final TermsAndConditions? termsAndConditions;
  final FetchStatus termsAndConditionsFetchStatus;
  final FormzSubmissionStatus submissionStatus;

  SignUpState copyWith({
    Dynamic<bool>? termsAndConditionsAccepted,
    Dynamic<String?>? name,
    Mobile? phone,
    Password? password,
    PasswordConfirmation? passwordConfirmation,
    Email? email,
    TermsAndConditions? termsAndConditions,
    FetchStatus? termsAndConditionsFetchStatus,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return SignUpState(
      termsAndConditionsAccepted:
          termsAndConditionsAccepted ?? this.termsAndConditionsAccepted,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
      email: email ?? this.email,
      termsAndConditions: termsAndConditions ?? this.termsAndConditions,
      termsAndConditionsFetchStatus:
          termsAndConditionsFetchStatus ?? this.termsAndConditionsFetchStatus,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
        termsAndConditionsAccepted,
        name,
        phone,
        password,
        passwordConfirmation,
        email,
        termsAndConditions,
        termsAndConditionsFetchStatus,
        submissionStatus,
      ];
}

enum FetchStatus { initial, loading, success, failure }