
import 'package:formz/formz.dart';

class AmountBTC extends FormzInput<double, AmountBTCValidationError> {
  const AmountBTC.unvalidated([
    double value = 0.00001,
  ]) : super.pure(value);

  const AmountBTC.validated([
    double value = 0.00001,
  ]) : super.dirty(value);

  @override
  AmountBTCValidationError? validator(double value) {
    if (value < 0.00001) {
      return AmountBTCValidationError.dust;
    } else if (value > 21000000) {
      return AmountBTCValidationError.invalid;
    } else {
      return null;
    }
  }
}

enum AmountBTCValidationError {
  dust,
  invalid,
}
