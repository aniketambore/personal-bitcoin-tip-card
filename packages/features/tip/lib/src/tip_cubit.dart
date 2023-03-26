import 'package:btc_pay_repository/btc_pay_repository.dart';
import 'package:lnurl_pay_repository/lnurl_pay_repository.dart';
import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:user_repository/user_repository.dart';

part 'tip_state.dart';

class TipCubit extends Cubit<TipState> {
  TipCubit({
    required this.btcPayRepository,
    required this.lnurlPayRepository,
    required this.userRepository,
  }) : super(
          const TipState(),
        );

  final BTCPayRepository btcPayRepository;
  final LNURLPayRepository lnurlPayRepository;
  final UserRepository userRepository;

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

  void onAmountBTCChanged(double newValue) {
    final previousScreenState = state;
    final previousAmountState = previousScreenState.amountBTC;
    final shouldValidate = previousAmountState.isNotValid;
    final newAmountState = shouldValidate
        ? AmountBTC.validated(
            newValue,
          )
        : AmountBTC.unvalidated(
            newValue,
          );

    final newScreenState = state.copyWith(
      amountBTC: newAmountState,
    );

    emit(newScreenState);
  }

  void onAmountBTCUnfocused() {
    final previousScreenState = state;
    final previousAmountState = previousScreenState.amountBTC;
    final previousAmountValue = previousAmountState.value;

    final newAmountState = AmountBTC.validated(
      previousAmountValue,
    );

    final newScreenState = previousScreenState.copyWith(
      amountBTC: newAmountState,
    );

    emit(newScreenState);
  }

  void onAmountSATChanged(int newValue) {
    final previousScreenState = state;
    final previousAmountState = previousScreenState.amountSAT;
    final shouldValidate = previousAmountState.isNotValid;
    final newAmountState = shouldValidate
        ? AmountSAT.validated(
            newValue,
          )
        : AmountSAT.unvalidated(
            newValue,
          );

    final newScreenState = state.copyWith(
      amountSAT: newAmountState,
    );

    emit(newScreenState);
  }

  void onAmountSATUnfocused() {
    final previousScreenState = state;
    final previousAmountState = previousScreenState.amountSAT;
    final previousAmountValue = previousAmountState.value;

    final newAmountState = AmountSAT.validated(
      previousAmountValue,
    );

    final newScreenState = previousScreenState.copyWith(
      amountSAT: newAmountState,
    );

    emit(newScreenState);
  }

  void onSubmit(bool isBtcUnit) async {
    final name = Name.validated(state.name.value);
    final message = Message.validated(state.message.value);
    final amountBTC = AmountBTC.validated(state.amountBTC.value);
    final amountSAT = AmountSAT.validated(state.amountSAT.value);

    final isFormValid = Formz.validate([
      name,
      message,
      amountBTC,
      amountSAT,
    ]);

    final newState = state.copyWith(
      name: name,
      message: message,
      amountBTC: amountBTC,
      amountSAT: amountSAT,
      submissionStatus: isFormValid ? SubmissionStatus.inProgress : null,
    );

    emit(newState);

    if (isFormValid) {
      try {
        if (isBtcUnit) {
          Invoice invoice = await btcPayRepository.createInvoice(
            name.value,
            message.value,
            amountBTC.value.toString(),
          );

          final newState = state.copyWith(
            submissionStatus: SubmissionStatus.success,
            invoice: invoice,
          );
          emit(newState);
        } else {
          lnurl(res) {
            final newState = state.copyWith(
                submissionStatus: SubmissionStatus.success,
                invoice: Invoice(checkoutLink: res));
            emit((newState));
          }

          await lnurlPayRepository.createInvoice(
            userRepository.getLud16,
            amountSAT.value,
            'Name:${name.value} | Message:${message.value}',
            (res) => lnurl(res),
          );
        }
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
