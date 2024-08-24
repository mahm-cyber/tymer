part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.name = const Name.unvalidated(),
    this.phone = const Mobile.unvalidated(),
    this.password = const Password.unvalidated(),
    this.passwordInfoOverlayShown = false,
    this.passwordInfoOverlayYOffset = 0.0,
    this.passwordConfirmation = const PasswordConfirmation.unvalidated(),
    this.email = const Email.unvalidated(),
    this.birthdate = const Birthdate.unvalidated(),
    this.city = const City.unvalidated(),
    this.gender = const Gender.unvalidated(),
    this.scrollDirection = ScrollDirection.forward,
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final Name name;
  final Mobile phone;
  final bool passwordInfoOverlayShown;
  final double passwordInfoOverlayYOffset;
  final Password password;
  final PasswordConfirmation passwordConfirmation;
  final Email email;
  final Birthdate birthdate;
  final City city;
  final Gender gender;
  final ScrollDirection scrollDirection;
  final FormzSubmissionStatus submissionStatus;

  SignUpState copyWith({
    Name? name,
    Mobile? phone,
    bool? passwordInfoOverlayShown,
    double? passwordInfoOverlayYOffset,
    ScrollController? scrollController,
    Password? password,
    PasswordConfirmation? passwordConfirmation,
    Email? email,
    Birthdate? birthdate,
    City? city,
    Gender? gender,
    ScrollDirection? scrollDirection,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return SignUpState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      passwordInfoOverlayShown:
          passwordInfoOverlayShown ?? this.passwordInfoOverlayShown,
      passwordInfoOverlayYOffset:
          passwordInfoOverlayYOffset ?? this.passwordInfoOverlayYOffset,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
      email: email ?? this.email,
      birthdate: birthdate ?? this.birthdate,
      city: city ?? this.city,
      gender: gender ?? this.gender,
      scrollDirection: scrollDirection ?? this.scrollDirection,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
        name,
        phone,
        passwordInfoOverlayShown,
        passwordInfoOverlayYOffset,
        password,
        passwordConfirmation,
        email,
        birthdate,
        city,
        gender,
        scrollDirection,
        submissionStatus,
      ];
}
