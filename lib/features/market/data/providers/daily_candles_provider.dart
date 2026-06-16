import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/minute_candle.dart';
import 'market_data_source_provider.dart';

final dailyCandlesProvider = FutureProvider.family<List<MinuteCandle>, String>((
  ref,
  symbol,
) async {
  final source = ref.watch(marketDataSourceProvider);
  return source.fetchDailyCandles(symbol);
});
