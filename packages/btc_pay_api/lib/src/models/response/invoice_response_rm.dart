import 'package:json_annotation/json_annotation.dart';

part 'invoice_response_rm.g.dart';

@JsonSerializable(createToJson: false)
class InvoiceResponseRM {
  const InvoiceResponseRM({
    required this.checkoutLink,
  });
  final String checkoutLink;

  static const fromJson = _$InvoiceResponseRMFromJson;
}
