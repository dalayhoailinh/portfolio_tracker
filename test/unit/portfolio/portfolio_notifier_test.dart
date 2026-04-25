import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_tracker/features/market/data/providers/market_notifier.dart';
import 'package:portfolio_tracker/features/market/domain/entities/market_state.dart';
import 'package:portfolio_tracker/features/market/domain/entities/stock_model.dart';
import 'package:portfolio_tracker/features/portfolio/data/providers/portfolio_notifier.dart';
import 'package:portfolio_tracker/features/portfolio/domain/entities/portfolio_state.dart';
import 'package:portfolio_tracker/features/portfolio/domain/entities/trading_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ProviderContainer> _buildContainer({List<StockModel>? stocks}) async {
  SharedPreferences.setMockInitialValues({});
  final container = ProviderContainer();

  if (stocks != null) {
    final marketNotifier = container.read(marketProvider.notifier);
    marketNotifier.state = MarketState(
      stocks: stocks,
      candles: const {},
      liveCandles: const {},
    );
  }

  container.read(portfolioProvider);
  await Future<void>.delayed(Duration.zero);
  return container;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PortfolioNotifier - initial state', () {
    test('starts at PortfolioState.initial when no saved data', () async {
      final container = await _buildContainer();
      addTearDown(container.dispose);

      expect(container.read(portfolioProvider), PortfolioState.initial);
    });
  });

  group('PortfolioNotifier.buy', () {
    test('creates a new position and reduces cash', () async {
      final container = await _buildContainer();
      addTearDown(container.dispose);

      final notifier = container.read(portfolioProvider.notifier);
      const stock = StockModel(
        symbol: 'AAPL',
        name: 'Apple Inc.',
        price: 100.0,
        seedPrice: 100.0,
      );

      await notifier.buy(stock: stock, quantity: 5);

      final state = container.read(portfolioProvider);
      expect(state.cash, 10000.0 - 500.0);
      expect(state.positions.length, 1);
      expect(state.positions['AAPL']!.quantity, 5);
      expect(state.positions['AAPL']!.avgBuyPrice, 100.0);
    });

    test('averages the buy price when buying the same symbol twice', () async {
      final container = await _buildContainer();
      addTearDown(container.dispose);

      final notifier = container.read(portfolioProvider.notifier);
      const s1 = StockModel(
        symbol: 'AAPL',
        name: 'Apple',
        price: 100,
        seedPrice: 100,
      );
      const s2 = StockModel(
        symbol: 'AAPL',
        name: 'Apple',
        price: 120,
        seedPrice: 100,
      );

      await notifier.buy(stock: s1, quantity: 10); // cost 1000 at 100
      await notifier.buy(stock: s2, quantity: 10); // cost 1200 at 120

      final pos = container.read(portfolioProvider).positions['AAPL']!;
      expect(pos.quantity, 20);
      // (1000 + 1200) / 20 = 110
      expect(pos.avgBuyPrice, closeTo(110.0, 0.0001));
    });

    test('throws InsufficientCashException when cost > cash', () async {
      final container = await _buildContainer();
      addTearDown(container.dispose);

      final notifier = container.read(portfolioProvider.notifier);
      const stock = StockModel(
        symbol: 'NVDA',
        name: 'NVIDIA',
        price: 5000.0,
        seedPrice: 5000.0,
      );

      expect(
        () => notifier.buy(stock: stock, quantity: 5), // 25,000 > 10,000
        throwsA(isA<InsufficientCashException>()),
      );
    });

    test(
      'throws InvalidQuantityException for zero or negative quantity',
      () async {
        final container = await _buildContainer();
        addTearDown(container.dispose);

        final notifier = container.read(portfolioProvider.notifier);
        const stock = StockModel(
          symbol: 'AAPL',
          name: 'Apple',
          price: 100,
          seedPrice: 100,
        );

        expect(
          () => notifier.buy(stock: stock, quantity: 0),
          throwsA(isA<InvalidQuantityException>()),
        );
      },
    );
  });

  group('PortfolioNotifier.withdraw', () {
    test('reduces quantity and adds proceeds to cash', () async {
      final container = await _buildContainer();
      addTearDown(container.dispose);

      final notifier = container.read(portfolioProvider.notifier);
      const stock = StockModel(
        symbol: 'AAPL',
        name: 'Apple',
        price: 100,
        seedPrice: 100,
      );

      await notifier.buy(stock: stock, quantity: 10);
      await notifier.withdraw(symbol: 'AAPL', quantity: 4, currentPrice: 120);

      final state = container.read(portfolioProvider);
      expect(state.positions['AAPL']!.quantity, 6);
      // cash after buy: 10000 - 1000 = 9000
      // cash after withdraw: 9000 + 4 * 120 = 9480
      expect(state.cash, 9480.0);
      // realized: (120 - 100) * 4 = 80
      expect(state.realizedPnL, 80.0);
    });

    test('removes the position when the last unit is withdrawn', () async {
      final container = await _buildContainer();
      addTearDown(container.dispose);

      final notifier = container.read(portfolioProvider.notifier);
      const stock = StockModel(
        symbol: 'AAPL',
        name: 'Apple',
        price: 100,
        seedPrice: 100,
      );

      await notifier.buy(stock: stock, quantity: 3);
      await notifier.withdraw(symbol: 'AAPL', quantity: 3, currentPrice: 110);

      expect(container.read(portfolioProvider).positions, isEmpty);
    });

    test(
      'throws InsufficientQuantityException when withdrawing more than owned',
      () async {
        final container = await _buildContainer();
        addTearDown(container.dispose);

        final notifier = container.read(portfolioProvider.notifier);
        const stock = StockModel(
          symbol: 'AAPL',
          name: 'Apple',
          price: 100,
          seedPrice: 100,
        );

        await notifier.buy(stock: stock, quantity: 2);

        expect(
          () =>
              notifier.withdraw(symbol: 'AAPL', quantity: 5, currentPrice: 100),
          throwsA(isA<InsufficientQuantityException>()),
        );
      },
    );

    test('throws PositionNotFoundException for unknown symbol', () async {
      final container = await _buildContainer();
      addTearDown(container.dispose);

      final notifier = container.read(portfolioProvider.notifier);
      expect(
        () => notifier.withdraw(symbol: 'XYZ', quantity: 1, currentPrice: 100),
        throwsA(isA<PositionNotFoundException>()),
      );
    });
  });

  group('PortfolioNotifier.resetPortfolio', () {
    test('restores initial state', () async {
      final container = await _buildContainer();
      addTearDown(container.dispose);

      final notifier = container.read(portfolioProvider.notifier);
      const stock = StockModel(
        symbol: 'AAPL',
        name: 'Apple',
        price: 100,
        seedPrice: 100,
      );

      await notifier.buy(stock: stock, quantity: 5);
      await notifier.resetPortfolio();

      expect(container.read(portfolioProvider), PortfolioState.initial);
    });
  });
}
