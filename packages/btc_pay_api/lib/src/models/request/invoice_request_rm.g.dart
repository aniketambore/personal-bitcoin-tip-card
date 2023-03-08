// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_request_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$InvoiceRequestRMToJson(InvoiceRequestRM instance) =>
    <String, dynamic>{
      'metadata': instance.metadata,
      'checkout': instance.checkout,
      'amount': instance.amount,
      'currency': instance.currency,
    };

Map<String, dynamic> _$MetaDataRMToJson(MetaDataRM instance) =>
    <String, dynamic>{
      'posData': instance.posData,
    };

Map<String, dynamic> _$PosDataRMToJson(PosDataRM instance) => <String, dynamic>{
      'name': instance.name,
      'msg': instance.msg,
    };

Map<String, dynamic> _$CheckoutRMToJson(CheckoutRM instance) =>
    <String, dynamic>{
      'speedPolicy': instance.speedPolicy,
    };
