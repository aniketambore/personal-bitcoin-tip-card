@JS()
library lnurl;

import 'package:js/js.dart';

@JS()
external Future<void> lnurlPay(String lnAddress, int amount, String message,
    void Function(String) onInvoiceCreatedCallback);

@JS()
external Future<void> sendPayment(String invoice);
