import 'package:freezed_annotation/freezed_annotation.dart';

part 'position.freezed.dart';
part 'position.g.dart';

@freezed
abstract class Position with _$Position {
  const Position._();

  const factory Position({
    required String symbol,
    required double quantity,
    required double avgBuyPrice,
  }) = _Position;

  factory Position.fromJson(Map<String, dynamic> json) =>
      _$PositionFromJson(json);

  double get totalCost => quantity * avgBuyPrice;

  double marketValue(double currentPrice) => quantity * currentPrice;

  double unrealizedPnl(double currentPrice) =>
      (currentPrice - avgBuyPrice) * quantity;

  double unrealizedPnlPercent(double currentPrice) =>
      avgBuyPrice == 0 ? 0 : ((currentPrice - avgBuyPrice) / avgBuyPrice) * 100;
}
