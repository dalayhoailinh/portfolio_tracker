import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/market_timeframe.dart';
import '../../domain/entities/minute_candle.dart';
import '../services/candle_aggregator.dart';
import 'market_notifier.dart';

typedef CandleQuery = ({String symbol, MarketTimeframe timeframe});

final aggregatedCandlesProvider =
    Provider.family<List<MinuteCandle>, CandleQuery>((ref, query) {
      final market = ref.watch(marketProvider);
      final m1 = market.candles[query.symbol] ?? const <MinuteCandle>[];
      return CandleAggregator.aggregate(
        m1Candles: m1,
        timeframe: query.timeframe,
      );
    });
