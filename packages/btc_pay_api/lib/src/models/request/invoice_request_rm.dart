import 'package:json_annotation/json_annotation.dart';

part 'invoice_request_rm.g.dart';

@JsonSerializable(createFactory: false)
class InvoiceRequestRM {
  const InvoiceRequestRM({
    required this.metadata,
    required this.checkout,
    required this.amount,
    required this.currency,
  });

  final MetaDataRM metadata;
  final CheckoutRM checkout;
  final String amount;
  final String currency;

  Map<String, dynamic> toJson() => _$InvoiceRequestRMToJson(this);
}

@JsonSerializable(createFactory: false)
class MetaDataRM {
  const MetaDataRM({
    required this.posData,
  });

  final PosDataRM posData;

  Map<String, dynamic> toJson() => _$MetaDataRMToJson(this);
}

@JsonSerializable(createFactory: false)
class PosDataRM {
  const PosDataRM({
    required this.name,
    required this.msg,
  });

  final String name;
  final String msg;

  Map<String, dynamic> toJson() => _$PosDataRMToJson(this);
}

@JsonSerializable(createFactory: false)
class CheckoutRM {
  const CheckoutRM({
    required this.speedPolicy,
  });

  final String speedPolicy;

  Map<String, dynamic> toJson() => _$CheckoutRMToJson(this);
}
