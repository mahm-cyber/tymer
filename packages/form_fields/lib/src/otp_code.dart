import 'package:formz/formz.dart';

class OtpCode extends FormzInput<String, OtpCodeValidationError> {
  const OtpCode.unvalidated([
    super.value = '',
  ])  : incorrectCode = false,
        super.pure();

  const OtpCode.validated(
    super.value, {
    this.incorrectCode = false,
  }) : super.dirty();
  final bool incorrectCode;

  @override
  OtpCodeValidationError? validator(String value) {
    if (isPure) return null;
    if(incorrectCode) return OtpCodeValidationError.incorrect;
    if (value.trim().isEmpty) return OtpCodeValidationError.empty;
    if (value.length < 4) return OtpCodeValidationError.incomplete;
    return null;
  }
}

enum OtpCodeValidationError {
  empty,
  incomplete,
  invalid,
  incorrect,
}
