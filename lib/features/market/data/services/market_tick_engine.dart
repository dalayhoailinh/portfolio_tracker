import 'dart:async';
import 'dart:math';

import '../../domain/entities/minute_candle.dart';

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
  final Map<String, _TickBuffer> _buffers = {};
  Map<String, double> _currentPrices = {};
  final Map<String, StreamSubscription<double>> _subscriptions = {};

  Timer? _alignmentTimer;
  Timer? _candleTimer;

  void Function(Map<String, double> prices)? _onTick;
  void Function(String symbol, MinuteCandle candle)? _onCandleClose;
  int Function(String symbol)? _candleIndexResolver;

  Duration _randomInterval() {
    final u1 = _random.nextDouble();
    final u2 = _random.nextDouble();
    final t = (u1 + u2) / 2;
    final ms = (100 + t * 2900).round();
    return Duration(milliseconds: ms);
  }

  double _randomChangePercent() {
    final u1 = _random.nextDouble();
    final u2 = _random.nextDouble();
    final t = (u1 + u2) / 2;
    return (t - 0.5) * 2;
  }

  Stream<double> _stockTickStream(double initialPrice) async* {
    double currentPrice = initialPrice;
    while (true) {
      await Future.delayed(_randomInterval());
      final changePercent = _randomChangePercent();
      currentPrice = (currentPrice * (1 + changePercent / 100)).clamp(
        0.01,
        double.infinity,
      );
      yield currentPrice;
    }
  }

  void start({
    required Map<String, double> initialPrices,
    required void Function(Map<String, double>) onTick,
    required void Function(String symbol, MinuteCandle candle) onCandleClose,
    required int Function(String symbol) candleIndexResolver,
  }) {
    _onTick = onTick;
    _onCandleClose = onCandleClose;
    _candleIndexResolver = candleIndexResolver;
    _currentPrices = Map.of(initialPrices);

    for (final entry in initialPrices.entries) {
      _buffers[entry.key] = _TickBuffer(entry.value);
      _subscriptions[entry.key] = _stockTickStream(
        entry.value,
      ).listen((price) => _handleSingleTick(entry.key, price));
    }

    _setupRealtimeCandleTimer();
  }

  void _setupRealtimeCandleTimer() {
    final now = DateTime.now();
    final msUntilNextMinute = (60 - now.second) * 1000 - now.millisecond;

    _alignmentTimer = Timer(Duration(milliseconds: msUntilNextMinute), () {
      _closeCandles();

      _candleTimer = Timer.periodic(const Duration(minutes: 1), (_) {
        _closeCandles();
      });
    });
  }

  void _handleSingleTick(String symbol, double price) {
    _currentPrices[symbol] = price;
    _buffers[symbol]?.update(price);

    _onTick?.call(Map.of(_currentPrices));
  }

  void _closeCandles() {
    for (final symbol in _buffers.keys) {
      final index = _candleIndexResolver?.call(symbol) ?? 0;
      final candle = _buffers[symbol]!.toCandle(index);
      _onCandleClose?.call(symbol, candle);

      _buffers[symbol]?.reset(_currentPrices[symbol]!);
    }
  }

  void stop() {
    for (final sub in _subscriptions.values) {
      sub.cancel();
    }
    _subscriptions.clear();

    _alignmentTimer?.cancel();
    _candleTimer?.cancel();
    _alignmentTimer = null;
    _candleTimer = null;

    _buffers.clear();
    _currentPrices.clear();
  }

  void dispose() => stop();
}
