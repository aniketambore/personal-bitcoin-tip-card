import 'package:btc_pay_repository/btc_pay_repository.dart';
import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

part 'tip_state.dart';

class TipCubit extends Cubit<TipState> {
  TipCubit({
    required this.btcPayRepository,
  }) : super(
          const TipState(),
        );

  final BTCPayRepository btcPayRepository;

  void onNameChanged(String newValue) {
    final previousScreenState = state;
    final previousNameState = previousScreenState.name;
    final shouldValidate = previousNameState.isNotValid;
    final newNameState = shouldValidate
        ? Name.validated(
            newValue,
          )
        : Name.unvalidated(
            newValue,
          );

    final newScreenState = state.copyWith(
      name: newNameState,
    );

    emit(newScreenState);
  }

  void onNameUnfocused() {
    final previousScreenState = state;
    final previousNameState = previousScreenState.name;
    final previousNameValue = previousNameState.value;

    final newNameState = Name.validated(
      previousNameValue,
    );

    final newScreenState = previousScreenState.copyWith(
      name: newNameState,
    );

    emit(newScreenState);
  }

  void onMessageChanged(String newValue) {
    final previousScreenState = state;
    final previousMessageState = previousScreenState.message;
    final shouldValidate = previousMessageState.isNotValid;
    final newMessageState = shouldValidate
        ? Message.validated(
            newValue,
          )
        : Message.unvalidated(
            newValue,
          );

    final newScreenState = state.copyWith(
      message: newMessageState,
    );

    emit(newScreenState);
  }

  void onMessageUnfocused() {
    final previousScreenState = state;
    final previousMessageState = previousScreenState.message;
    final previousMessageValue = previousMessageState.value;

    final newMessageState = Message.validated(
      previousMessageValue,
    );

    final newScreenState = previousScreenState.copyWith(
      message: newMessageState,
    );

    emit(newScreenState);
  }

  void onAmountChanged(double newValue) {
    final previousScreenState = state;
    final previousAmountState = previousScreenState.amount;
    final shouldValidate = previousAmountState.isNotValid;
    final newAmountState = shouldValidate
        ? Amount.validated(
            newValue,
          )
        : Amount.unvalidated(
            newValue,
          );

    final newScreenState = state.copyWith(
      amount: newAmountState,
    );

    emit(newScreenState);
  }

  void onAmountUnfocused() {
    final previousScreenState = state;
    final previousAmountState = previousScreenState.amount;
    final previousAmountValue = previousAmountState.value;

    final newAmountState = Amount.validated(
      previousAmountValue,
    );

    final newScreenState = previousScreenState.copyWith(
      amount: newAmountState,
    );

    emit(newScreenState);
  }

  void onSubmit() async {
    final name = Name.validated(state.name.value);
    final message = Message.validated(state.message.value);
    final amount = Amount.validated(state.amount.value);

    final isFormValid = Formz.validate([
      name,
      message,
      amount,
    ]);

    final newState = state.copyWith(
      name: name,
      message: message,
      amount: amount,
      submissionStatus: isFormValid ? SubmissionStatus.inProgress : null,
    );

    emit(newState);

    if (isFormValid) {
      try {
        final invoice = await btcPayRepository.createInvoice(
          name.value,
          message.value,
          amount.value.toString(),
        );
        final newState = state.copyWith(
          submissionStatus: SubmissionStatus.success,
          invoice: invoice,
        );
        emit(newState);
      } catch (error) {
        final newState = state.copyWith(
          submissionStatus: (error is BadRequestException ||
                  error is ForbiddenException ||
                  error is UnauthorizedException)
              ? SubmissionStatus.apiError
              : SubmissionStatus.genericError,
        );
        emit(newState);
      }
    }
  }
}
