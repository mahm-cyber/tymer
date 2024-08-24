import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class Domain extends FormzInput<String?, DomainValidationError>
    with EquatableMixin {
  const Domain.unvalidated([
    super.value = '',
  ]) : super.pure();

  const Domain.validated(super.value) : super.dirty();

  static final _domainRegex =
      RegExp(r'^(?!://)([a-zA-Z0-9-_]+\.)+[a-zA-Z]{2,}$');

  @override
  DomainValidationError? validator(String? value) {
    if (isPure) return null;
    if (value == null) return DomainValidationError.empty;
    if (value.isEmpty) return DomainValidationError.empty;
    if (!_domainRegex.hasMatch(value)) {
      return DomainValidationError.invalidFormat;
    }
    return null;
  }

  @override
  List<Object?> get props => [
        value,
        isPure,
      ];
}

enum DomainValidationError {
  empty,
  invalidFormat,
}
