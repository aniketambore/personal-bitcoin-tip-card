import 'package:equatable/equatable.dart';

class Invoice extends Equatable {
  const Invoice({
    required this.checkoutLink,
  });

  final String checkoutLink;

  @override
  List<Object?> get props => [
        checkoutLink,
      ];
}
