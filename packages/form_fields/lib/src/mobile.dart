import 'package:formz/formz.dart';

class Mobile extends FormzInput<String?, MobileValidationError> {
  const Mobile.unvalidated([
    super.value = '',
    this.isAlreadyRegistered = false,
    this.invalidCredentials = false,
    this.unVerified = false,
    this.isNotRegistered = false,
  ]) : super.pure();

  const Mobile.validated(
    super.value, {
    this.isAlreadyRegistered = false,
    this.invalidCredentials = false,
    this.unVerified = false,
    this.isNotRegistered = false,
  }) : super.dirty();

// egyptian mobiel number regex
  final bool isAlreadyRegistered;
  final bool invalidCredentials;
  final bool unVerified;
  final bool isNotRegistered;
  static const _mobileRegex = r'^01[0-2,5]{1}[0-9]{8}$';

  @override
  MobileValidationError? validator(String? value) {
    if (isPure) return null;
    if (isNotRegistered) {
      return MobileValidationError.isNotRegistered;
    }
    if (unVerified) {
      return MobileValidationError.unverified;
    }
    if (invalidCredentials) {
      return MobileValidationError.invalidCredentials;
    }
    if (isAlreadyRegistered) {
      return MobileValidationError.isAlreadyRegistered;
    }
    if (value == null) return MobileValidationError.empty;
    if (value.isEmpty) return MobileValidationError.empty;
    if (!RegExp(_mobileRegex).hasMatch(value)) {
      return MobileValidationError.invalidFormat;
    }

    return null;
  }
}

enum MobileValidationError {
  empty,
  invalidFormat,
  isAlreadyRegistered,
  invalidCredentials,
  unverified,
  isNotRegistered,
}
