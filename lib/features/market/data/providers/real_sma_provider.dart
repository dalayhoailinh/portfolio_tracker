import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'daily_candles_provider.dart';
import 'indicator_engine_provider.dart';

typedef RealSmaQuery = ({String symbol, int window});

final realSmaProvider = FutureProvider.family<List<double?>, RealSmaQuery>((
  ref,
  query,
) async {
  final candles = await ref.watch(dailyCandlesProvider(query.symbol).future);
  final closes = [for (final candle in candles) candle.close];
  final engine = ref.watch(indicatorEngineProvider);
  return engine.sma(closes: closes, window: query.window);
});
