import 'dart:convert';
import 'package:btc_pay_api/src/models/models.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

class BTCPayApi {
  BTCPayApi({
    @visibleForTesting Dio? dio,
    required this.url,
    required String btcPayToken,
    required String btcPayUsername,
    required String btcPayPassword,
  }) : _dio = dio ?? Dio() {
    _dio.setUpAuthHeaders(btcPayToken, btcPayUsername, btcPayPassword);
    // _dio.interceptors.add(
    //   LogInterceptor(responseBody: false),
    // );
  }

  final Dio _dio;
  final String url;

  Future<InvoiceResponseRM> createInvoice(
      String name, String msg, String amount) async {
    try {
      final requestJsonBody = InvoiceRequestRM(
        metadata: MetaDataRM(
          posData: PosDataRM(
            name: name,
            msg: msg,
          ),
        ),
        checkout: const CheckoutRM(
          speedPolicy: 'LowMediumSpeed',
        ),
        amount: amount,
        currency: 'BTC',
      ).toJson();

      final response = await _dio.post(
        url,
        data: requestJsonBody,
      );

      final jsonObject = response.data;

      final invoice = InvoiceResponseRM.fromJson(jsonObject);

      return invoice;
    } on DioError catch (error) {
      print('[!] [btcpay_api.dart | createInvoice]: [Error: $error]');
      final errorCode = error.response?.statusCode;
      switch (errorCode) {
        case 400:
          throw BadRequestBTCPayException();
        case 401:
          throw UnauthorizedBTCPayException();
        case 403:
          throw ForbiddenBTCPayException();
        default:
          rethrow;
      }
    }
  }
}

extension on Dio {
  void setUpAuthHeaders(
    String btcPayToken,
    String btcPayUsername,
    String btcPayPassword,
  ) {
    options = BaseOptions(headers: {
      'authorization':
          'Basic ${base64Encode(utf8.encode('$btcPayUsername:$btcPayPassword'))}',
      'token': btcPayToken,
    });
  }
}
