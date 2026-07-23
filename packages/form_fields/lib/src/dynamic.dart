import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class Dynamic<T> extends FormzInput<T?, DynamicValidationError>
    with EquatableMixin {
  const Dynamic.unvalidated([super.value])
      : isRequired = false,
        checkIfNumber = false,
        shouldCheckIfEgyptianMobile = false,
        shouldCheckIfIbanNumber = false,
        isGreatherThan = null,
        super.pure();

  const Dynamic.validated(
    super.value, {
    this.isRequired = false,
    this.checkIfNumber = false,
    this.shouldCheckIfEgyptianMobile = false,
    this.shouldCheckIfIbanNumber = false,
    this.isGreatherThan,
  }) : super.dirty();

  final bool isRequired;
  final bool checkIfNumber;
  final bool shouldCheckIfEgyptianMobile;
  final bool shouldCheckIfIbanNumber;
  final int? isGreatherThan;
  @override
  DynamicValidationError? validator(T? value) {
    if (isPure) return null;

    if (value == null && isRequired) {
      return DynamicValidationError.empty;
    }
    if (value is String && value.trim().isEmpty == true && isRequired) {
      return DynamicValidationError.empty;
    }

    if (value is String && checkIfNumber && double.tryParse(value) == null) {
      return DynamicValidationError.isNotNumber;
    }
    if (value is String && isGreatherThan != null) {
      final isGreaterThanZero = double.tryParse(value) != null &&
          double.parse(value) >= isGreatherThan!;
      if (!isGreaterThanZero) {
        return DynamicValidationError.isNotGreaterThanZero;
      }
    }
    if (value is String && shouldCheckIfEgyptianMobile) {
      final isEgyptianMobile = checkIfEgyptianMobile(value);
      if (!isEgyptianMobile) {
        return DynamicValidationError.isNotEgyptianMobile;
      }
    }
    if (value is String && shouldCheckIfIbanNumber) {
      final isIbanNumber = checkIfIbanNumber(value);
      if (!isIbanNumber) {
        return DynamicValidationError.isNotIbanNumber;
      }
    }
    return null;
  }

  @override
  List<Object?> get props => [
        value,
        isPure,
      ];
}

enum DynamicValidationError {
  empty,
  isNotNumber,
  isNotEgyptianMobile,
  isNotIbanNumber,
  isNotGreaterThanZero,
}

bool checkIfEgyptianMobile(String value) {
  if (value.length != 11) return false;
  if (!value.startsWith('01')) return false;
  if (!RegExp(r'^[0-9]+$').hasMatch(value)) return false;
  return true;
}

bool checkIfIbanNumber(String value) {
  const lengthOfIbanNumber = 'EG121234567890'.length;
  if (value.length < lengthOfIbanNumber) return false;
  //starts with alphabetical characters
  if (!RegExp(r'^[a-zA-Z]{2}').hasMatch(value.substring(0, 2))) return false;

  return true;
}
