part of 'tip_cubit.dart';

class TipState extends Equatable {
  const TipState({
    this.name = const Name.unvalidated(),
    this.message = const Message.unvalidated(),
    this.amountBTC = const AmountBTC.unvalidated(),
    this.amountSAT = const AmountSAT.unvalidated(),
    this.submissionStatus = SubmissionStatus.idle,
    this.invoice,
  });

  final Name name;
  final Message message;
  final AmountBTC amountBTC;
  final AmountSAT amountSAT;
  final SubmissionStatus submissionStatus;

  final Invoice? invoice;

  TipState copyWith({
    Name? name,
    Message? message,
    AmountBTC? amountBTC,
    AmountSAT? amountSAT,
    SubmissionStatus? submissionStatus,
    Invoice? invoice,
  }) {
    return TipState(
      name: name ?? this.name,
      message: message ?? this.message,
      amountBTC: amountBTC ?? this.amountBTC,
      amountSAT: amountSAT ?? this.amountSAT,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      invoice: invoice ?? this.invoice,
    );
  }

  @override
  List<Object?> get props => [
        name,
        message,
        amountBTC,
        amountSAT,
        submissionStatus,
      ];
}

enum SubmissionStatus {
  idle,
  inProgress,
  success,
  genericError,
  apiError,
}
