import 'dart:math';

import '../../domain/entities/market_timeframe.dart';
import '../../domain/entities/minute_candle.dart';

class CandleAggregator {
  const CandleAggregator._();

  static List<MinuteCandle> aggregate({
    required List<MinuteCandle> m1Candles,
    required MarketTimeframe timeframe,
  }) {
    if (m1Candles.isEmpty) return const [];
    if (timeframe == MarketTimeframe.m1) return m1Candles;

    final multiplier = timeframe.multiplier;
    final result = <MinuteCandle>[];

    for (int i = 0; i < m1Candles.length; i += multiplier) {
      final end = (i + multiplier) > m1Candles.length
          ? m1Candles.length
          : (i + multiplier);
      final slice = m1Candles.sublist(i, end);

      final open = slice.first.open;
      final close = slice.last.close;
      final high = slice.map((c) => c.high).reduce(max);
      final low = slice.map((c) => c.low).reduce(min);

      result.add(
        MinuteCandle(
          index: i ~/ multiplier,
          open: open,
          close: close,
          high: high,
          low: low,
        ),
      );
    }

    return result;
  }
}
