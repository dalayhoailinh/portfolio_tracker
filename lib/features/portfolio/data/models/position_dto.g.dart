// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PositionDto _$PositionDtoFromJson(Map<String, dynamic> json) => _PositionDto(
  symbol: json['symbol'] as String,
  quantity: (json['quantity'] as num).toDouble(),
  avgBuyPrice: (json['avgBuyPrice'] as num).toDouble(),
);

Map<String, dynamic> _$PositionDtoToJson(_PositionDto instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'quantity': instance.quantity,
      'avgBuyPrice': instance.avgBuyPrice,
    };
