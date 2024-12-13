import 'package:domain_models/domain_models.dart';
import 'package:formz/formz.dart';

class OtpCode extends FormzInput<String, OtpCodeValidationError> {
  const OtpCode.unvalidated([
    super.value = '',
  ])  : incorrectCode = false,
        limitExceeded = null,
        super.pure();

  const OtpCode.validated(
    super.value, {
    this.incorrectCode = false,
    this.limitExceeded,
  }) : super.dirty();
  final bool incorrectCode;
  final OtpRateLimitExceededException? limitExceeded;

  @override
  OtpCodeValidationError? validator(String value) {
    if (isPure) return null;
    if (limitExceeded != null) return OtpCodeValidationError.limitExceeded;
    if (incorrectCode) return OtpCodeValidationError.incorrect;
    if (value.trim().isEmpty) return OtpCodeValidationError.empty;
    if (value.length < 6) return OtpCodeValidationError.incomplete;
    return null;
  }
}

enum OtpCodeValidationError {
  empty,
  incomplete,
  invalid,
  incorrect,
  limitExceeded,
}
