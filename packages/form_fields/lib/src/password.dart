import 'package:formz/formz.dart';

class Password extends FormzInput<String?, PasswordValidationError> {
  const Password.unvalidated([
    super.value = '',
  ])  : invalidCredentials = false,
        shouldCheckStrength = false,
        super.pure();

  const Password.validated(
      super.value, {
        this.invalidCredentials = false,
        this.shouldCheckStrength = true,
      }) : super.dirty();
  final bool invalidCredentials;
  final bool shouldCheckStrength;

  @override
  PasswordValidationError? validator(String? value) {
    if (isPure) return null;
    if (value == null) return PasswordValidationError.empty;
    if (value.isEmpty) return PasswordValidationError.empty;

    final bool isStrongPassword = value.checkPasswordStrength();
    if (shouldCheckStrength && (!isStrongPassword)) {
      return PasswordValidationError.weak;
    }

    if (invalidCredentials) return PasswordValidationError.invalidCredentials;
    return null;
  }
}

enum PasswordValidationError {
  empty,
  weak,
  invalidCredentials,
}

extension CheckPasswordStrength on String {
  bool checkPasswordStrength() {
    // Password length greater than 6
    if (length < 8) {
      return false;
    }

    // Contains at least one uppercase letter
    // if (!contains(RegExp(r'[A-Z]'))) {
    //   return false;
    // }

    // Contains at least one lowercase letter
    // if (!contains(RegExp(r'[a-z]'))) {
    //   return false;
    // }

    // Contains at least one digit
    // if (!contains(RegExp(r'[0-9]'))) {
    //   return false;
    // }

    // Contains at least one special character
    // if (!contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
    //   return false;
    // }

    // If there are no error messages, the password is valid
    return true;
  }
}
