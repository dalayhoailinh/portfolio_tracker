import '../entities/minute_candle.dart';
import '../entities/stock_model.dart';

abstract class IMarketRepository {
  Future<void> saveStocks(List<StockModel> stocks);
  Future<List<StockModel>?> loadStocks();
  Future<void> saveCandles(Map<String, List<MinuteCandle>> candles);
  Future<Map<String, List<MinuteCandle>>?> loadCandles();
  Future<void> clear();
}
