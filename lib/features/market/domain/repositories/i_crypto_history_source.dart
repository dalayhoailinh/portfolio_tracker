import '../entities/minute_candle.dart';

abstract class ICryptoHistorySource {
  Future<List<MinuteCandle>> fetchRecentMinuteBars(String symbol);
  Future<Map<String, double>> fetchLatestPrices(List<String> symbols);
}
