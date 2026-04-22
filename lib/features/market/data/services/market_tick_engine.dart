import 'dart:async';
import 'dart:math';

import '../../domain/entities/minute_candle.dart';

const int kTicksPerMinute = 60;

class _TickBuffer {
  double open;
  double high;
  double low;
  double lastPrice;

  _TickBuffer(double price)
    : open = price,
      high = price,
      low = price,
      lastPrice = price;

  void update(double price) {
    if (price > high) high = price;
    if (price < low) low = price;
    lastPrice = price;
  }

  MinuteCandle toCandle(int index) => MinuteCandle(
    index: index,
    open: open,
    high: high,
    low: low,
    close: lastPrice,
  );

  void reset(double newOpenPrice) {
    open = newOpenPrice;
    high = newOpenPrice;
    low = newOpenPrice;
    lastPrice = newOpenPrice;
  }
}

class MarketTickEngine {
  final _random = Random();
  Timer? _timer;
  int _tickCount = 0;
  final Map<String, _TickBuffer> _buffers = {};
  Map<String, double> _currentPrices = {};

  void Function(
    Map<String, double> prices,
    Map<String, MinuteCandle> liveCandles,
  )?
  _onTick;
  void Function(String symbol, MinuteCandle candle)? _onCandleClose;
  int Function(String symbol)? _candleIndexResolver;

  void start({
    required Map<String, double> initialPrices,
    required void Function(Map<String, double>, Map<String, MinuteCandle>)
    onTick,
    required void Function(String symbol, MinuteCandle candle) onCandleClose,
    required int Function(String symbol) candleIndexResolver,
  }) {
    _onTick = onTick;
    _onCandleClose = onCandleClose;
    _candleIndexResolver = candleIndexResolver;
    _currentPrices = Map.of(initialPrices);
    _tickCount = 0;

    for (final entry in initialPrices.entries) {
      _buffers[entry.key] = _TickBuffer(entry.value);
    }

    _timer = Timer.periodic(const Duration(seconds: 1), _handleTick);
  }

  void _handleTick(Timer _) {
    final liveCandles = <String, MinuteCandle>{};
    for (final symbol in _currentPrices.keys) {
      final current = _currentPrices[symbol]!;
      final change = (_random.nextDouble() - 0.5) * 0.02;
      final newPrice = (current * (1 + change / 100)).clamp(
        0.01,
        double.infinity,
      );
      _currentPrices[symbol] = newPrice;
      _buffers[symbol]?.update(newPrice);

      final index = _candleIndexResolver?.call(symbol) ?? 0;
      liveCandles[symbol] = _buffers[symbol]!.toCandle(index);
    }

    _onTick?.call(Map.of(_currentPrices), liveCandles);

    for (final symbol in _buffers.keys) {
      final buffer = _buffers[symbol]!;
      final index = _candleIndexResolver?.call(symbol) ?? 0;
      liveCandles[symbol] = buffer.toCandle(index);
    }

    _tickCount++;
    if (_tickCount >= kTicksPerMinute) {
      for (final symbol in _buffers.keys) {
        final index = _candleIndexResolver?.call(symbol) ?? 0;
        final candle = _buffers[symbol]!.toCandle(index);
        _onCandleClose?.call(symbol, candle);
        _buffers[symbol]!.reset(_currentPrices[symbol]!);
      }
      _tickCount = 0;
    }
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    _tickCount = 0;
    _buffers.clear();
    _currentPrices.clear();
  }

  void dispose() => stop();
}
