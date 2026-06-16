import '../entities/minute_candle.dart';

abstract class IMarketDataSource {
  Future<List<MinuteCandle>> fetchDailyCandles(String symbol);
}
