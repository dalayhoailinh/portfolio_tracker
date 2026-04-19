// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PortfolioState _$PortfolioStateFromJson(Map<String, dynamic> json) =>
    _PortfolioState(
      cash: (json['cash'] as num).toDouble(),
      realizedPnL: (json['realizedPnL'] as num).toDouble(),
      unrealizedPnL: (json['unrealizedPnL'] as num).toDouble(),
      positions:
          (json['positions'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Position.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
    );

Map<String, dynamic> _$PortfolioStateToJson(_PortfolioState instance) =>
    <String, dynamic>{
      'cash': instance.cash,
      'realizedPnL': instance.realizedPnL,
      'unrealizedPnL': instance.unrealizedPnL,
      'positions': instance.positions,
    };
