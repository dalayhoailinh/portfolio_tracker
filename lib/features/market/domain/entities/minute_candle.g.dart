// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'minute_candle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MinuteCandle _$MinuteCandleFromJson(Map<String, dynamic> json) =>
    _MinuteCandle(
      open: (json['open'] as num).toDouble(),
      high: (json['high'] as num).toDouble(),
      low: (json['low'] as num).toDouble(),
      close: (json['close'] as num).toDouble(),
    );

Map<String, dynamic> _$MinuteCandleToJson(_MinuteCandle instance) =>
    <String, dynamic>{
      'open': instance.open,
      'high': instance.high,
      'low': instance.low,
      'close': instance.close,
    };
