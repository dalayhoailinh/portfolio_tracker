import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/i_live_price_source.dart';
import '../services/alpaca_price_stream.dart';

const List<String> kLiveSymbols = ['BTC/USD', 'ETH/USD', 'LTC/USD'];

final livePriceSourceProvider = Provider<ILivePriceSource>((ref) {
  return AlpacaPriceStream();
});

final livePricesProvider = StreamProvider.autoDispose<Map<String, double>>((
  ref,
) {
  final source = ref.watch(livePriceSourceProvider);
  final latest = <String, double>{};
  return source.watchTrades(kLiveSymbols).map((tick) {
    latest[tick.symbol] = tick.price;
    return Map<String, double>.unmodifiable(latest);
  });
});
