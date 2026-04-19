// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Position _$PositionFromJson(Map<String, dynamic> json) => _Position(
  symbol: json['symbol'] as String,
  quantity: (json['quantity'] as num).toDouble(),
  avgBuyPrice: (json['avgBuyPrice'] as num).toDouble(),
);

Map<String, dynamic> _$PositionToJson(_Position instance) => <String, dynamic>{
  'symbol': instance.symbol,
  'quantity': instance.quantity,
  'avgBuyPrice': instance.avgBuyPrice,
};
