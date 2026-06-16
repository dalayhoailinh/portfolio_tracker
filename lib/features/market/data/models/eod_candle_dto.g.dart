// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eod_candle_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EodCandleDto _$EodCandleDtoFromJson(Map<String, dynamic> json) =>
    _EodCandleDto(
      date: DateTime.parse(json['date'] as String),
      open: (json['open'] as num).toDouble(),
      high: (json['high'] as num).toDouble(),
      low: (json['low'] as num).toDouble(),
      close: (json['close'] as num).toDouble(),
    );

Map<String, dynamic> _$EodCandleDtoToJson(_EodCandleDto instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'open': instance.open,
      'high': instance.high,
      'low': instance.low,
      'close': instance.close,
    };
