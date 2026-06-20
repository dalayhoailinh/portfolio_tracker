import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/minute_candle.dart';
import '../../domain/repositories/i_crypto_history_source.dart';
import '../services/alpaca_crypto_history_source.dart';
import 'live_price_provider.dart';

final cryptoHistorySourceProvider = Provider<ICryptoHistorySource>((ref) {
  return AlpacaCryptoHistorySource();
});

final cryptoBarsProvider = FutureProvider.family<List<MinuteCandle>, String>((
  ref,
  symbol,
) {
  return ref.watch(cryptoHistorySourceProvider).fetchRecentMinuteBars(symbol);
});

final lastKnownPricesProvider = FutureProvider<Map<String, double>>((ref) {
  return ref.watch(cryptoHistorySourceProvider).fetchLatestPrices(kLiveSymbols);
});
