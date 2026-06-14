import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/market_timeframe.dart';
import 'aggregated_candles_provider.dart';
import 'indicator_engine_provider.dart';

typedef SmaQuery = ({String symbol, MarketTimeframe timeframe, int window});

final smaOverlayProvider = FutureProvider.family<List<double?>, SmaQuery>((
  ref,
  query,
) {
  final candles = ref.watch(
    aggregatedCandlesProvider((
      symbol: query.symbol,
      timeframe: query.timeframe,
    )),
  );
  final closes = [for (final candle in candles) candle.close];

  final engine = ref.watch(indicatorEngineProvider);
  return engine.sma(closes: closes, window: query.window);
});
