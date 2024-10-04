import 'package:formz/formz.dart';

class OtpCode extends FormzInput<String, OtpCodeValidationError> {
  const OtpCode.unvalidated([
    super.value = '',
  ])  : incorrectCode = false,
        limitCrossed = false,
        super.pure();

  const OtpCode.validated(
    super.value, {
    this.incorrectCode = false,
    this.limitCrossed = false,
  }) : super.dirty();
  final bool incorrectCode;
  final bool limitCrossed;

  @override
  OtpCodeValidationError? validator(String value) {
    if (isPure) return null;
    if(limitCrossed) return OtpCodeValidationError.limitCrossed;
    if (incorrectCode) return OtpCodeValidationError.incorrect;
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
  limitCrossed,
}
