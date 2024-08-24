import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class Dynamic<T> extends FormzInput<T?, DynamicValidationError>
    with EquatableMixin {
  const Dynamic.unvalidated([super.value])
      : isRequired = false,
        super.pure();

  const Dynamic.validated(
    super.value, {
    this.isRequired = false,
  }) : super.dirty();

  final bool isRequired;

  @override
  DynamicValidationError? validator(T? value) {
    if (isPure) return null;

    if (value == null && isRequired) {
      return DynamicValidationError.empty;
    }
    if (value is String && value.trim().isEmpty == true && isRequired) {
      return DynamicValidationError.empty;
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
}
