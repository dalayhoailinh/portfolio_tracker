import 'package:freezed_annotation/freezed_annotation.dart';

part 'portfolio_state.freezed.dart';
part 'portfolio_state.g.dart';

@freezed
abstract class PortfolioState with _$PortfolioState {
  const PortfolioState._();

  const factory PortfolioState({
    required double cash,
    required double realizedPnL,
    required double unrealizedPnL,
  }) = _PortfolioState;

  static const PortfolioState initial = PortfolioState(
    cash: 10000.0,
    realizedPnL: 0.0,
    unrealizedPnL: 0.0,
  );

  factory PortfolioState.fromJson(Map<String, dynamic> json) =>
      _$PortfolioStateFromJson(json);

  double get totalEquity => cash + unrealizedPnL;
}
