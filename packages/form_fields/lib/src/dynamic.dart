import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class Dynamic<T> extends FormzInput<T?, DynamicValidationError>
    with EquatableMixin {
  const Dynamic.unvalidated([super.value])
      : isRequired = false,
        checkIfNumber = false,
        shouldCheckIfEgyptianMobile = false,
        super.pure();

  const Dynamic.validated(
    super.value, {
    this.isRequired = false,
    this.checkIfNumber = false,
    this.shouldCheckIfEgyptianMobile = false,
  }) : super.dirty();

  final bool isRequired;
  final bool checkIfNumber;
  final bool shouldCheckIfEgyptianMobile;
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
    if (value is String &&
        shouldCheckIfEgyptianMobile &&
        checkIfEgyptianMobile(value)) {
      return DynamicValidationError.isNotEgyptianMobile;
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
}

bool checkIfEgyptianMobile(String value) {
  if (value.length != 11) return false;
  if (!value.startsWith('01')) return false;
  if (!RegExp(r'^[0-9]+$').hasMatch(value)) return false;
  return true;
}
