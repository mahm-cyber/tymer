import 'package:equatable/equatable.dart';
import 'package:form_fields/src/password.dart';
import 'package:formz/formz.dart';


class PasswordConfirmation
    extends FormzInput<String, PasswordConfirmationValidationError>
    with EquatableMixin {
  const PasswordConfirmation.unvalidated([
    super.value = '',
  ])  : password = const Password.unvalidated(),
        super.pure();

  const PasswordConfirmation.validated(
    super.value, {
    required this.password,
  }) : super.dirty();

  final Password password;

  @override
  PasswordConfirmationValidationError? validator(String value) {
    if (isPure) return null;
    if (value.isEmpty) return PasswordConfirmationValidationError.empty;
    if (value != password.value) {
      return PasswordConfirmationValidationError.doesNotMatch;
    }
    return null;
  }

  @override
  List<Object?> get props => [
        value,
        isPure,
        password,
      ];
}

enum PasswordConfirmationValidationError {
  empty,
  doesNotMatch,
}
