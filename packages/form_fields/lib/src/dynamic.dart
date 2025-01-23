import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class Dynamic<T> extends FormzInput<T?, DynamicValidationError>
    with EquatableMixin {
  const Dynamic.unvalidated([super.value])
      : isRequired = false,
        isNumber = false,
        super.pure();

  const Dynamic.validated(
    super.value, {
    this.isRequired = false,
    this.isNumber = false,
  }) : super.dirty();

  final bool isRequired;
  final bool isNumber;

  @override
  DynamicValidationError? validator(T? value) {
    if (isPure) return null;

    if (value == null && isRequired) {
      return DynamicValidationError.empty;
    }
    if (value is String && value.trim().isEmpty == true && isRequired) {
      return DynamicValidationError.empty;

    }

    if (value is String && isNumber && double.tryParse(value) == null) {
      return DynamicValidationError.isNotNumber;
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
}
