import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class Email extends FormzInput<String?, EmailValidationError>
    with EquatableMixin {
  const Email.unvalidated([
    super.value = '',
  ])  : isAlreadyRegistered = false,
        isNotRegistered = false,
        invalidCredentials = false,
        invalidFormat = false,
        isRequired = false,
        super.pure();

  const Email.validated(
      super.value, {
        this.isAlreadyRegistered = false,
        this.isNotRegistered = false,
        this.invalidCredentials = false,
        this.invalidFormat = false,
        this.isRequired = false,
      }) : super.dirty();

  // static final _emailRegex = RegExp(
  //   '^(([\\w-]+\\.)+[\\w-]+|([a-zA-Z]|[\\w-]{2,}))@((([0-1]?'
  //   '[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\.([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\.'
  //   '([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\.([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])'
  //   ')|([a-zA-Z]+[\\w-]+\\.)+[a-zA-Z]{2,4})\$',
  // );
  // static final _emailRegex = RegExp(
  //   r'^[a-zA-Z\d._%+-]+@[a-zA-Z\d.-]+\.[a-zA-Z]{2,}$',
  // );
  final bool isAlreadyRegistered;
  final bool isNotRegistered;
  final bool invalidCredentials;
  final bool invalidFormat;
  final bool isRequired;

  @override
  EmailValidationError? validator(String? value) {
    if (isPure) return null;
    if (value == null && isRequired) return EmailValidationError.empty;
    if (value?.isEmpty == true && isRequired) return EmailValidationError.empty;
    if (isAlreadyRegistered) return EmailValidationError.alreadyRegistered;
    if (isNotRegistered) return EmailValidationError.isNotRegistered;
    if (invalidCredentials) return EmailValidationError.invalidCredentials;
    // if (value != null &&
    //     value.isNotEmpty &&
    //     (!_emailRegex.hasMatch(value) || invalidFormat)) {
    //   return EmailValidationError.invalidFormat;
    // }
    return null;
  }

  @override
  List<Object?> get props => [
    value,
    isAlreadyRegistered,
    isNotRegistered,
    invalidCredentials,
    invalidFormat,
    isPure,
  ];
}

enum EmailValidationError {
  empty,
  invalidFormat,
  alreadyRegistered,
  isNotRegistered,
  invalidCredentials,
  isDisposable,
}
