import 'package:formz/formz.dart';

class Message extends FormzInput<String, MessageValidationError> {
  const Message.unvalidated([
    String value = '',
  ]) : super.pure(value);

  const Message.validated([
    String value = '',
  ]) : super.dirty(value);

  @override
  MessageValidationError? validator(String value) {
    return null;
  }
}

enum MessageValidationError {
  empty,
}
