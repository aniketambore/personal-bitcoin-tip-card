import 'package:js/js.dart';

import 'lnurl_pay_js_interop.dart' as lnurl;

class LNURLPayAPI {
  Future<void> requestInvoice(String lnAddress, int amount, String message,
      void Function(String) onInvoiceCreatedCallback) async {
    await lnurl.lnurlPay(
        lnAddress, amount, message, allowInterop(onInvoiceCreatedCallback));
  }

  Future<void> sendPayment(String invoice) async {
    await lnurl.sendPayment(invoice);
  }
}
