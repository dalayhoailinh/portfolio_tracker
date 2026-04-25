import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_tracker/features/market/data/services/candle_aggregator.dart';
import 'package:portfolio_tracker/features/market/domain/entities/market_timeframe.dart';
import 'package:portfolio_tracker/features/market/domain/entities/minute_candle.dart';

MinuteCandle c(int i, double o, double h, double l, double close) =>
    MinuteCandle(index: i, open: o, high: h, low: l, close: close);

void main() {
  group('CandleAggregator.aggregate', () {
    test('returns empty list for empty input', () {
      final result = CandleAggregator.aggregate(
        m1Candles: const [],
        timeframe: MarketTimeframe.m5,
      );
      expect(result, isEmpty);
    });

    test('m1 timeframe returns the input unchanged', () {
      final input = [c(0, 100, 105, 98, 102), c(1, 102, 110, 101, 108)];
      final result = CandleAggregator.aggregate(
        m1Candles: input,
        timeframe: MarketTimeframe.m1,
      );
      expect(result, input);
    });

    test('m5 groups 5 m1 candles into one', () {
      final input = [
        c(0, 100, 105, 98, 102),
        c(1, 102, 107, 100, 106),
        c(2, 106, 108, 104, 105),
        c(3, 105, 110, 103, 109),
        c(4, 109, 112, 108, 111),
      ];
      final result = CandleAggregator.aggregate(
        m1Candles: input,
        timeframe: MarketTimeframe.m5,
      );
      expect(result.length, 1);
      expect(result[0].open, 100); // first open
      expect(result[0].close, 111); // last close
      expect(result[0].high, 112); // max high
      expect(result[0].low, 98); // min low
      expect(result[0].index, 0); // i // multiplier = 0
    });

    test('m5 keeps the last partial bucket', () {
      // 7 m1 candles -> one full m5 + one partial (2 candles)
      final input = List.generate(
        7,
        (i) => c(
          i,
          100 + i.toDouble(),
          (105 + i).toDouble(),
          (95 + i).toDouble(),
          (102 + i).toDouble(),
        ),
      );
      final result = CandleAggregator.aggregate(
        m1Candles: input,
        timeframe: MarketTimeframe.m5,
      );
      expect(result.length, 2);
      expect(result[0].index, 0);
      expect(result[1].index, 1);
      // Partial bucket uses last 2 candles
      expect(result[1].open, 105);
      expect(result[1].close, 108);
    });

    test('h1 aggregates 60 m1 candles into one', () {
      final input = List.generate(60, (i) => c(i, 100, 100, 100, 100));
      final result = CandleAggregator.aggregate(
        m1Candles: input,
        timeframe: MarketTimeframe.h1,
      );
      expect(result.length, 1);
    });
  });
}
