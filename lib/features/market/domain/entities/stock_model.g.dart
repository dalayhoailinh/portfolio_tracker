// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StockModel _$StockModelFromJson(Map<String, dynamic> json) => _StockModel(
  symbol: json['symbol'] as String,
  name: json['name'] as String,
  price: (json['price'] as num).toDouble(),
  seedPrice: (json['seedPrice'] as num).toDouble(),
  changePercent: (json['changePercent'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$StockModelToJson(_StockModel instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'name': instance.name,
      'price': instance.price,
      'seedPrice': instance.seedPrice,
      'changePercent': instance.changePercent,
    };
