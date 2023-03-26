import 'package:lnurl_pay_api/lnurl_pay_api.dart';

class LNURLPayRepository {
  LNURLPayRepository({
    required this.lnurlPayAPI,
  });

  final LNURLPayAPI lnurlPayAPI;

  Future<void> createInvoice(String lnAddress, int amount, String message,
      void Function(String) onInvoiceCreatedCallback) async {
    await lnurlPayAPI.requestInvoice(
        lnAddress, amount, message, onInvoiceCreatedCallback);
  }

  Future<void> sendPayment(String invoice) async {
    await lnurlPayAPI.sendPayment(invoice);
  }
}
