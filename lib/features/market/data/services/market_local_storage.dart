import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/minute_candle.dart';
import '../../domain/entities/stock_model.dart';
import '../../domain/repositories/i_market_repository.dart';
import '../models/minute_candle_dto.dart';
import '../models/stock_dto.dart';

class LocalStorageException implements Exception {
  final String message;
  LocalStorageException(this.message);
  @override
  String toString() => 'LocalStorageException: $message';
}

class MarketLocalStorage implements IMarketRepository {
  static const String _stocksKey = 'market_stocks';
  static const String _candlesKey = 'market_candles';

  @override
  Future<void> saveStocks(List<StockModel> stocks) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final dtos = stocks.map((s) => StockDto.fromEntity(s)).toList();
      final encoded = jsonEncode(dtos.map((d) => d.toJson()).toList());
      await prefs.setString(_stocksKey, encoded);
    } catch (e) {
      throw LocalStorageException('Failed to save stocks: $e');
    }
  }

  @override
  Future<List<StockModel>?> loadStocks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final encoded = prefs.getString(_stocksKey);
      if (encoded == null) return null;
      final List<dynamic> decoded = jsonDecode(encoded);
      return decoded
          .map((e) => StockDto.fromJson(e as Map<String, dynamic>).toEntity())
          .toList();
    } catch (e) {
      throw LocalStorageException('Failed to load stocks: $e');
    }
  }

  @override
  Future<void> saveCandles(Map<String, List<MinuteCandle>> candles) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final dtos = candles.map(
        (key, list) => MapEntry(
          key,
          list.map((c) => MinuteCandleDto.fromEntity(c).toJson()).toList(),
        ),
      );
      final encoded = jsonEncode(dtos);
      await prefs.setString(_candlesKey, encoded);
    } catch (e) {
      throw LocalStorageException('Failed to save candles: $e');
    }
  }

  @override
  Future<Map<String, List<MinuteCandle>>?> loadCandles() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final encoded = prefs.getString(_candlesKey);
      if (encoded == null) return null;
      final Map<String, dynamic> decoded = jsonDecode(encoded);
      return decoded.map(
        (key, value) => MapEntry(
          key,
          (value as List)
              .map(
                (e) => MinuteCandleDto.fromJson(
                  e as Map<String, dynamic>,
                ).toEntity(),
              )
              .toList(),
        ),
      );
    } catch (e) {
      throw LocalStorageException('Failed to load candles: $e');
    }
  }

  @override
  Future<void> clear() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_stocksKey);
      await prefs.remove(_candlesKey);
    } catch (e) {
      throw LocalStorageException('Failed to clear market data: $e');
    }
  }
}
