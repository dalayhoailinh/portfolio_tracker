import 'package:freezed_annotation/freezed_annotation.dart';

import 'minute_candle.dart';
import 'stock_model.dart';

part 'market_state.freezed.dart';

@freezed
abstract class MarketState with _$MarketState {
  const factory MarketState({
    required List<StockModel> stocks,
    required Map<String, List<MinuteCandle>> candles,
    required Map<String, MinuteCandle> liveCandles,
  }) = _MarketState;

  factory MarketState.initial() =>
      const MarketState(stocks: kSeedStocks, candles: {}, liveCandles: {});
}
