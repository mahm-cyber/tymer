
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class FileSize<T> extends FormzInput<File?, FileSizeValidationError>
    with EquatableMixin {
  const FileSize.unvalidated([super.value])
      : sizeLimitInKb = 0,
        super.pure();

  const FileSize.validated(
    super.value, {
    required this.sizeLimitInKb,
  }) : super.dirty();

  final int sizeLimitInKb;

  @override
  FileSizeValidationError? validator(File? value) {
    if (isPure) return null;
    final bytes = value?.readAsBytesSync().lengthInBytes;
    final sizeInKb = (bytes ?? 0) / 1024;
    if (sizeInKb > sizeLimitInKb) {
      return FileSizeValidationError.exceedsSizeLimit;
    }

    return null;
  }

  @override
  List<Object?> get props => [
        value,
        isPure,
      ];
}

enum FileSizeValidationError {
  exceedsSizeLimit,
}
