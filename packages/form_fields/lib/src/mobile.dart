import 'package:formz/formz.dart';

class Mobile extends FormzInput<String?, MobileValidationError> {
  const Mobile.unvalidated([
    super.value = '',
  ])  :
        super.pure();

  const Mobile.validated(
      super.value, ) : super.dirty();
// egyptian mobiel number regex
  static const _mobileRegex = r'^01[0-2,5]{1}[0-9]{8}$';

  @override
  MobileValidationError? validator(String? value) {
    if (isPure) return null;
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
}

