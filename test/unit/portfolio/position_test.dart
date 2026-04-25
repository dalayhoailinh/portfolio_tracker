import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_tracker/features/market/domain/entities/position.dart';

void main() {
  group('Position', () {
    const pos = Position(symbol: 'AAPL', quantity: 10, avgBuyPrice: 100.0);

    test('totalCost = quantity x avgBuyPrice', () {
      expect(pos.totalCost, 1000.0);
    });

    test('marketValue scales with current price', () {
      expect(pos.marketValue(120.0), 1200.0);
      expect(pos.marketValue(80.0), 800.0);
    });

    test('unrealizedPnl is positive when price above avg', () {
      expect(pos.unrealizedPnl(110.0), 100.0); // +10 x 10
    });

    test('unrealizedPnl is negative when price below avg', () {
      expect(pos.unrealizedPnl(95.0), -50.0); // -5 x 10
    });

    test('unrealizedPnlPercent is zero when avgBuyPrice is zero', () {
      const free = Position(symbol: 'X', quantity: 5, avgBuyPrice: 0);
      expect(free.unrealizedPnlPercent(100.0), 0);
    });

    test('unrealizedPnlPercent reflects price delta', () {
      expect(pos.unrealizedPnlPercent(110.0), 10.0);
      expect(pos.unrealizedPnlPercent(90.0), -10.0);
    });

    test('value equality from freezed', () {
      const a = Position(symbol: 'AAPL', quantity: 10, avgBuyPrice: 100);
      const b = Position(symbol: 'AAPL', quantity: 10, avgBuyPrice: 100);
      expect(a == b, isTrue);
      expect(a.hashCode, b.hashCode);
    });
  });
}
