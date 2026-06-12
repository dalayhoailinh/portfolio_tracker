// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_state_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PortfolioStateDto _$PortfolioStateDtoFromJson(Map<String, dynamic> json) =>
    _PortfolioStateDto(
      cash: (json['cash'] as num).toDouble(),
      realizedPnL: (json['realizedPnL'] as num).toDouble(),
      unrealizedPnL: (json['unrealizedPnL'] as num).toDouble(),
      positions:
          (json['positions'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, PositionDto.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
    );

Map<String, dynamic> _$PortfolioStateDtoToJson(_PortfolioStateDto instance) =>
    <String, dynamic>{
      'cash': instance.cash,
      'realizedPnL': instance.realizedPnL,
      'unrealizedPnL': instance.unrealizedPnL,
      'positions': instance.positions,
    };
