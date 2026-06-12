import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../market/data/providers/market_notifier.dart';
import '../../../market/domain/entities/market_state.dart';
import '../../domain/entities/position.dart';
import '../../../market/domain/entities/stock_model.dart';
import '../../domain/entities/portfolio_state.dart';
import '../../domain/repositories/i_portfolio_repository.dart';
import '../../domain/services/portfolio_service.dart';
import '../services/portfolio_local_storage.dart';

class PortfolioNotifier extends StateNotifier<PortfolioState> {
  final IPortfolioRepository _storage;
  final PortfolioService _service;
  final Ref _ref;

  PortfolioNotifier({
    required IPortfolioRepository storage,
    required PortfolioService service,
    required Ref ref,
  }) : _storage = storage,
       _service = service,
       _ref = ref,
       super(PortfolioState.initial) {
    _init();
  }

  Future<void> _init() async {
    final saved = await _storage.load();
    if (saved != null) state = saved;
    _listenToMarket();
  }

  void _listenToMarket() {
    _ref.listen<MarketState>(marketProvider, (previous, next) {
      final newState = _service.recomputeUnrealizedPnl(state, next.stocks);
      if (newState != state) {
        state = newState;
      }
    });
  }

  Future<void> buy({
    required StockModel stock,
    required double quantity,
  }) async {
    state = _service.buy(state, stock, quantity);
    await _storage.save(state);
  }

  Future<void> withdraw({
    required String symbol,
    required double quantity,
    required double currentPrice,
  }) async {
    state = _service.withdraw(state, symbol, quantity, currentPrice);
    await _storage.save(state);
  }

  Future<void> resetPortfolio() async {
    state = PortfolioState.initial;
    await _storage.clear();
  }

  Future<void> setUnrealizedPnl(double value) async {
    state = state.copyWith(unrealizedPnL: value);
    await _storage.save(state);
  }

  Future<void> setRealizedPnl(double value) async {
    state = state.copyWith(realizedPnL: value);
    await _storage.save(state);
  }
}

final portfolioProvider =
    StateNotifierProvider<PortfolioNotifier, PortfolioState>((ref) {
      return PortfolioNotifier(
        storage: PortfolioLocalStorage(),
        service: PortfolioService(),
        ref: ref,
      );
    });
