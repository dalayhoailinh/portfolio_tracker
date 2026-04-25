import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_tracker/features/market/domain/entities/position.dart';
import 'package:portfolio_tracker/features/portfolio/domain/entities/portfolio_state.dart';

void main() {
  group('PortfolioState.initial', () {
    test('starts with 10,000 cash and no positions', () {
      expect(PortfolioState.initial.cash, 10000.0);
      expect(PortfolioState.initial.realizedPnL, 0.0);
      expect(PortfolioState.initial.unrealizedPnL, 0.0);
      expect(PortfolioState.initial.positions, isEmpty);
    });

    test('initial totalEquity equals initial cash', () {
      expect(PortfolioState.initial.totalEquity, 10000.0);
    });
  });

  group('PortfolioState getters with positions', () {
    const aapl = Position(symbol: 'AAPL', quantity: 10, avgBuyPrice: 100.0);
    const googl = Position(symbol: 'GOOGL', quantity: 5, avgBuyPrice: 140.0);

    const state = PortfolioState(
      cash: 5000.0,
      realizedPnL: 0.0,
      unrealizedPnL: 200.0,
      positions: {'AAPL': aapl, 'GOOGL': googl},
    );

    test('totalCostBasis sums position costs', () {
      // 10 x 100 + 5 x 140 = 1000 + 700 = 1700
      expect(state.totalCostBasis, 1700.0);
    });

    test('totalEquity = cash + totalCostBasis + unrealizedPnL', () {
      // 5000 + 1700 + 200 = 6900
      expect(state.totalEquity, 6900.0);
    });

    test('totalEquity drops with negative unrealizedPnL', () {
      final losing = state.copyWith(unrealizedPnL: -300.0);
      // 5000 + 1700 - 300 = 6400
      expect(losing.totalEquity, 6400.0);
    });
  });
}
