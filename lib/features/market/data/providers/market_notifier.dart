import 'package:flutter_riverpod/legacy.dart';

import '../../domain/entities/market_state.dart';
import '../../domain/entities/minute_candle.dart';
import '../../domain/entities/stock_model.dart';
import '../services/market_local_storage.dart';
import '../services/market_tick_engine.dart';

class MarketNotifier extends StateNotifier<MarketState> {
  final MarketLocalStorage _storage;
  final MarketTickEngine _engine;

  MarketNotifier({
    required MarketLocalStorage storage,
    required MarketTickEngine engine,
  }) : _storage = storage,
       _engine = engine,
       super(MarketState.initial()) {
    _init();
  }

  Future<void> _init() async {
    final savedStocks = await _storage.loadStocks();
    final savedCandles = await _storage.loadCandles();

    final stocks = savedStocks ?? kSeedStocks;
    final candles = savedCandles ?? {};

    state = state.copyWith(stocks: stocks, candles: candles);
    _startEngine(stocks);
  }

  void _startEngine(List<StockModel> stocks) {
    final priceMap = {for (var s in stocks) s.symbol: s.price};

    _engine.start(
      initialPrices: priceMap,
      onTick: _onTick,
      onCandleClose: _onCandleClose,
      candleIndexResolver: (symbol) => state.candles[symbol]?.length ?? 0,
    );
  }

  void _onTick(
    Map<String, double> prices,
    Map<String, MinuteCandle> liveCandles,
  ) {
    final updatedStocks = state.stocks.map((s) {
      final newPrice = prices[s.symbol];
      if (newPrice == null) return s;

      final changePercent = ((newPrice - s.price) / s.price) * 100;
      return s.copyWith(
        price: double.parse(newPrice.toStringAsFixed(2)),
        changePercent: double.parse(changePercent.toStringAsFixed(2)),
      );
    }).toList();

    state = state.copyWith(stocks: updatedStocks, liveCandles: liveCandles);
  }

  void _onCandleClose(String symbol, MinuteCandle candle) {
    final updatedCandles = Map<String, List<MinuteCandle>>.from(state.candles);
    final symbolCandles = List<MinuteCandle>.from(updatedCandles[symbol] ?? []);
    symbolCandles.add(candle);
    updatedCandles[symbol] = symbolCandles;

    state = state.copyWith(candles: Map.unmodifiable(updatedCandles));

    _storage.saveStocks(state.stocks);
    _storage.saveCandles(updatedCandles);
  }

  Future<void> resetMarket() async {
    _engine.stop();
    await _storage.clear();
    state = MarketState.initial();
    _startEngine(state.stocks);
  }

  @override
  void dispose() {
    _engine.stop();
    super.dispose();
  }
}

final marketProvider = StateNotifierProvider<MarketNotifier, MarketState>(
  (ref) =>
      MarketNotifier(storage: MarketLocalStorage(), engine: MarketTickEngine()),
);
