import 'package:flutter_riverpod/legacy.dart';

import '../../../market/data/providers/market_notifier.dart';
import '../../../market/domain/entities/market_state.dart';
import '../../../market/domain/entities/stock_model.dart';
import '../../domain/entities/portfolio_state.dart';
import '../../domain/repositories/i_portfolio_repository.dart';
import '../../domain/services/portfolio_service.dart';
import '../services/portfolio_local_storage.dart';

class PortfolioNotifier extends StateNotifier<PortfolioState> {
  final IPortfolioRepository _storage;
  final PortfolioService _service;

  PortfolioNotifier({
    required IPortfolioRepository storage,
    required PortfolioService service,
  }) : _storage = storage,
       _service = service,
       super(PortfolioState.initial) {
    _init();
  }

  Future<void> _init() async {
    final saved = await _storage.load();
    if (saved != null) state = saved;
  }

  void applyMarketPrices(List<StockModel> stocks) {
    final newState = _service.recomputeUnrealizedPnl(state, stocks);
    if (newState != state) state = newState;
  }

  Future<void> buy({
    required StockModel stock,
    required double quantity,
  }) async {
    final newState = _service.buy(state, stock, quantity);
    await _storage.save(newState);
    state = newState;
  }

  Future<void> withdraw({
    required String symbol,
    required double quantity,
    required double currentPrice,
  }) async {
    final newState = _service.withdraw(state, symbol, quantity, currentPrice);
    await _storage.save(newState);
    state = newState;
  }

  Future<void> resetPortfolio() async {
    await _storage.clear();
    state = PortfolioState.initial;
  }
}

final portfolioProvider =
    StateNotifierProvider<PortfolioNotifier, PortfolioState>((ref) {
      final notifier = PortfolioNotifier(
        storage: PortfolioLocalStorage(),
        service: PortfolioService(),
      );

      ref.listen<MarketState>(marketProvider, (previous, next) {
        notifier.applyMarketPrices(next.stocks);
      });

      return notifier;
    });
