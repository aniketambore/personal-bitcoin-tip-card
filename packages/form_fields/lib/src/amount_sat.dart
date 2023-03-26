import 'package:formz/formz.dart';

class AmountSAT extends FormzInput<int, AmountSATValidationError> {
  const AmountSAT.unvalidated([
    int value = 1,
  ]) : super.pure(value);

  const AmountSAT.validated([value]) : super.dirty(value);

  @override
  AmountSATValidationError? validator(int value) {
    if (value < 1) {
      return AmountSATValidationError.invalid;
    } else if (value > 11000000) {
      return AmountSATValidationError.onchain;
    } else {
      return null;
    }
  }
}

enum AmountSATValidationError {
  onchain,
  invalid,
}
