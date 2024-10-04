part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.name = const Dynamic<String?>.unvalidated(),
    this.phone = const Mobile.unvalidated(),
    this.password = const Password.unvalidated(),
    this.termsAndConditionsAccepted = const Dynamic<bool>.unvalidated(),
    this.passwordConfirmation = const PasswordConfirmation.unvalidated(),
    this.email = const Email.unvalidated(),
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final Dynamic<bool> termsAndConditionsAccepted;
  final Dynamic<String?> name;
  final Mobile phone;
  final Password password;
  final PasswordConfirmation passwordConfirmation;
  final Email email;
  final FormzSubmissionStatus submissionStatus;

  SignUpState copyWith({
    Dynamic<bool>? termsAndConditionsAccepted,
    Dynamic<String?>? name,
    Mobile? phone,
    Password? password,
    PasswordConfirmation? passwordConfirmation,
    Email? email,
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
        submissionStatus,
      ];
}
