import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/minute_candle.dart';
import '../../domain/entities/stock_model.dart';

class MarketLocalStorage {
  static const String _stocksKey = 'market_stocks';
  static const String _candlesKey = 'market_candles';

  Future<void> saveStocks(List<StockModel> stocks) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(stocks.map((s) => s.toJson()).toList());
    await prefs.setString(_stocksKey, encoded);
  }

  Future<List<StockModel>?> loadStocks() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = prefs.getString(_stocksKey);
    if (encoded == null) return null;
    final List<dynamic> decoded = jsonDecode(encoded);
    return decoded.map((e) => StockModel.fromJson(e)).toList();
  }

  Future<void> saveCandles(Map<String, List<MinuteCandle>> candles) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(candles);
    await prefs.setString(_candlesKey, encoded);
  }

  Future<Map<String, List<MinuteCandle>>?> loadCandles() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = prefs.getString(_candlesKey);
    if (encoded == null) return null;
    final Map<String, dynamic> decoded = jsonDecode(encoded);
    return decoded.map(
      (key, value) => MapEntry(
        key,
        (value as List).map((e) => MinuteCandle.fromJson(e)).toList(),
      ),
    );
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_stocksKey);
    await prefs.remove(_candlesKey);
  }
}
