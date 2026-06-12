// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'minute_candle_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MinuteCandleDto _$MinuteCandleDtoFromJson(Map<String, dynamic> json) =>
    _MinuteCandleDto(
      index: (json['index'] as num).toInt(),
      open: (json['open'] as num).toDouble(),
      high: (json['high'] as num).toDouble(),
      low: (json['low'] as num).toDouble(),
      close: (json['close'] as num).toDouble(),
    );

Map<String, dynamic> _$MinuteCandleDtoToJson(_MinuteCandleDto instance) =>
    <String, dynamic>{
      'index': instance.index,
      'open': instance.open,
      'high': instance.high,
      'low': instance.low,
      'close': instance.close,
    };
