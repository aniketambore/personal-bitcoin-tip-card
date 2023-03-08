import 'package:btc_pay_api/btc_pay_api.dart';
import 'package:btc_pay_repository/src/mappers/mappers.dart';
import 'package:domain_models/domain_models.dart';

class BTCPayRepository {
  BTCPayRepository({
    required this.remoteApi,
  });

  final BTCPayApi remoteApi;

  Future<Invoice> createInvoice(String name, String msg, String amount) async {
    final invoiceResponse = await _createRemoteInvoice(name, msg, amount);
    final domainInvoice = invoiceResponse.toDomainModel();
    return domainInvoice;
  }

  Future<InvoiceResponseRM> _createRemoteInvoice(
    String name,
    String msg,
    String amount,
  ) async {
    try {
      return await remoteApi.createInvoice(name, msg, amount);
    } catch (error) {
      _handleError(error);
      rethrow;
    }
  }

  void _handleError(error) {
    if (error is BadRequestBTCPayException) {
      throw BadRequestException();
    } else if (error is ForbiddenBTCPayException) {
      throw ForbiddenException();
    } else if (error is UnauthorizedBTCPayException) {
      throw UnauthorizedException();
    }
    print('[!] [BTCPayRepository]: [Error: $error]');
  }
}
