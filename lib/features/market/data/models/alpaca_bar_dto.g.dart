// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alpaca_bar_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AlpacaBarDto _$AlpacaBarDtoFromJson(Map<String, dynamic> json) =>
    _AlpacaBarDto(
      open: (json['o'] as num).toDouble(),
      high: (json['h'] as num).toDouble(),
      low: (json['l'] as num).toDouble(),
      close: (json['c'] as num).toDouble(),
    );

Map<String, dynamic> _$AlpacaBarDtoToJson(_AlpacaBarDto instance) =>
    <String, dynamic>{
      'o': instance.open,
      'h': instance.high,
      'l': instance.low,
      'c': instance.close,
    };
