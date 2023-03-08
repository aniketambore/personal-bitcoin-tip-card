part of 'tip_cubit.dart';

class TipState extends Equatable {
  const TipState({
    this.name = const Name.unvalidated(),
    this.message = const Message.unvalidated(),
    this.amount = const Amount.unvalidated(),
    this.submissionStatus = SubmissionStatus.idle,
    this.invoice,
  });

  final Name name;
  final Message message;
  final Amount amount;
  final SubmissionStatus submissionStatus;

  final Invoice? invoice;

  TipState copyWith({
    Name? name,
    Message? message,
    Amount? amount,
    SubmissionStatus? submissionStatus,
    Invoice? invoice,
  }) {
    return TipState(
      name: name ?? this.name,
      message: message ?? this.message,
      amount: amount ?? this.amount,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      invoice: invoice ?? this.invoice,
    );
  }

  @override
  List<Object?> get props => [
        name,
        message,
        amount,
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
