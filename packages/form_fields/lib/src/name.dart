import 'package:formz/formz.dart';

class Name extends FormzInput<String, NameValidationError> {
  const Name.unvalidated([
    String value = '',
  ]) : super.pure(value);

  const Name.validated([
    String value = '',
  ]) : super.dirty(value);

  @override
  NameValidationError? validator(String value) {
    return null;
  }
}

enum NameValidationError {
  empty,
}
