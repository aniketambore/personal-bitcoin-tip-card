import 'package:formz/formz.dart';

class Amount extends FormzInput<double, AmountValidationError> {
  const Amount.unvalidated([
    double value = 0.00001,
  ]) : super.pure(value);

  const Amount.validated([
    double value = 0.00001,
  ]) : super.dirty(value);

  @override
  AmountValidationError? validator(double value) {
    if (value < 0.00001) {
      return AmountValidationError.dust;
    } else if (value > 21000000) {
      return AmountValidationError.invalid;
    } else {
      return null;
    }
  }
}

enum AmountValidationError {
  dust,
  invalid,
}
