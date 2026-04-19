import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../market/data/providers/market_notifier.dart';
import '../../../market/domain/entities/market_state.dart';
import '../../../market/domain/entities/position.dart';
import '../../../market/domain/entities/stock_model.dart';
import '../../domain/entities/portfolio_state.dart';
import '../../domain/entities/trading_exception.dart';
import '../services/portfolio_local_storage.dart';

class PortfolioNotifier extends StateNotifier<PortfolioState> {
  final PortfolioLocalStorage _storage;
  final Ref _ref;

  PortfolioNotifier({required PortfolioLocalStorage storage, required Ref ref})
    : _storage = storage,
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
      _recomputeUnrealizedPnl(next.stocks);
    });
  }

  void _recomputeUnrealizedPnl(List<StockModel> stocks) {
    if (state.positions.isEmpty) {
      if (state.unrealizedPnL != 0) {
        state = state.copyWith(unrealizedPnL: 0);
      }
      return;
    }

    final priceMap = {for (final s in stocks) s.symbol: s.price};

    double total = 0;
    for (final pos in state.positions.values) {
      final price = priceMap[pos.symbol] ?? pos.avgBuyPrice;
      total += pos.unrealizedPnl(price);
    }

    final rounded = double.parse(total.toStringAsFixed(2));
    if (rounded != state.unrealizedPnL) {
      state = state.copyWith(unrealizedPnL: rounded);
    }
  }

  Future<void> buy({
    required StockModel stock,
    required double quantity,
  }) async {
    if (quantity <= 0) throw InvalidQuantityException();

    final cost = stock.price * quantity;
    if (cost > state.cash) {
      throw InsufficientCashException(required: cost, available: state.cash);
    }

    final updatedPositions = Map<String, Position>.from(state.positions);

    final existing = updatedPositions[stock.symbol];
    if (existing == null) {
      updatedPositions[stock.symbol] = Position(
        symbol: stock.symbol,
        quantity: quantity,
        avgBuyPrice: stock.price,
      );
    } else {
      final newQty = existing.quantity + quantity;
      final newAvg = (existing.totalCost + cost) / newQty;
      updatedPositions[stock.symbol] = existing.copyWith(
        quantity: newQty,
        avgBuyPrice: double.parse(newAvg.toStringAsFixed(4)),
      );
    }

    state = state.copyWith(
      cash: double.parse((state.cash - cost).toStringAsFixed(2)),
      positions: updatedPositions,
    );

    await _storage.save(state);
  }

  Future<void> withdraw({
    required String symbol,
    required double quantity,
    required double currentPrice,
  }) async {
    if (quantity <= 0) throw InvalidQuantityException();
    final pos = state.positions[symbol];
    if (pos == null) throw PositionNotFoundException(symbol);

    if (quantity > pos.quantity) {
      throw InsufficientQuantityException(
        requested: quantity,
        available: pos.quantity,
      );
    }

    final proceeds = currentPrice * quantity;
    final realizedDelta = (currentPrice - pos.avgBuyPrice) * quantity;

    final updatedPositions = Map<String, Position>.from(state.positions);
    final remaining = pos.quantity - quantity;

    if (remaining <= 0) {
      updatedPositions.remove(symbol);
    } else {
      updatedPositions[symbol] = pos.copyWith(quantity: remaining);
    }

    state = state.copyWith(
      cash: double.parse((state.cash + proceeds).toStringAsFixed(2)),
      positions: updatedPositions,
      realizedPnL: double.parse(
        (state.realizedPnL + realizedDelta).toStringAsFixed(2),
      ),
    );
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
      return PortfolioNotifier(storage: PortfolioLocalStorage(), ref: ref);
    });
