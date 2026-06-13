import '../../../market/domain/entities/stock_model.dart';
import '../entities/portfolio_state.dart';
import '../entities/position.dart';
import '../entities/trading_exception.dart';

double _money(double value) => double.parse(value.toStringAsFixed(2));

double _avgPrice(double value) => double.parse(value.toStringAsFixed(4));

class PortfolioService {
  PortfolioState recomputeUnrealizedPnl(
    PortfolioState state,
    List<StockModel> stocks,
  ) {
    if (state.positions.isEmpty) {
      if (state.unrealizedPnL != 0) {
        return state.copyWith(unrealizedPnL: 0);
      }
      return state;
    }

    final priceMap = {for (final s in stocks) s.symbol: s.price};

    double total = 0;
    for (final pos in state.positions.values) {
      final price = priceMap[pos.symbol] ?? pos.avgBuyPrice;
      total += pos.unrealizedPnl(price);
    }

    final rounded = _money(total);
    if (rounded != state.unrealizedPnL) {
      return state.copyWith(unrealizedPnL: rounded);
    }
    return state;
  }

  PortfolioState buy(PortfolioState state, StockModel stock, double quantity) {
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
        avgBuyPrice: _avgPrice(newAvg),
      );
    }

    return state.copyWith(
      cash: _money(state.cash - cost),
      positions: updatedPositions,
    );
  }

  PortfolioState withdraw(
    PortfolioState state,
    String symbol,
    double quantity,
    double currentPrice,
  ) {
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

    return state.copyWith(
      cash: _money(state.cash + proceeds),
      positions: updatedPositions,
      realizedPnL: _money(state.realizedPnL + realizedDelta),
    );
  }
}
