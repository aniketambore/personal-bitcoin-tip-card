import 'package:btc_pay_api/btc_pay_api.dart';
import 'package:domain_models/domain_models.dart';

extension InvoiceResponseRMtoDomain on InvoiceResponseRM {
  Invoice toDomainModel() {
    return Invoice(
      checkoutLink: checkoutLink,
    );
  }
}
