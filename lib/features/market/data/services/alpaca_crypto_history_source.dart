import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../app/api_config.dart';
import '../../domain/entities/market_data_exception.dart';
import '../../domain/entities/minute_candle.dart';
import '../../domain/repositories/i_crypto_history_source.dart';
import '../models/alpaca_bar_dto.dart';

class AlpacaCryptoHistorySource implements ICryptoHistorySource {
  final http.Client _client;
  final String _key;
  final String _secret;

  AlpacaCryptoHistorySource({http.Client? client, String? key, String? secret})
    : _client = client ?? http.Client(),
      _key = key ?? ApiConfig.alpacaKey,
      _secret = secret ?? ApiConfig.alpacaSecret;

  Map<String, String> get _headers => {
    'APCA-API-KEY-ID': _key,
    'APCA-API-SECRET-KEY': _secret,
  };

  @override
  Future<List<MinuteCandle>> fetchRecentMinuteBars(String symbol) async {
    final start = DateTime.now().toUtc().subtract(const Duration(hours: 18));
    final uri = Uri.parse('${ApiConfig.alpacaCryptoDataUrl}/bars').replace(
      queryParameters: {
        'symbols': symbol,
        'timeframe': '1Min',
        'start': start.toIso8601String(),
        'limit': '1000',
        'sort': 'asc',
      },
    );

    final http.Response res;
    try {
      res = await _client.get(uri, headers: _headers);
    } catch (e) {
      throw NetworkException('Could not reach Alpaca: $e');
    }
    if (res.statusCode == 401 || res.statusCode == 403) {
      throw ApiKeyException(symbol);
    }
    if (res.statusCode != 200) {
      throw MarketDataException(
        'Alpaca bars HTTP ${res.statusCode} for $symbol',
      );
    }

    try {
      final decoded = jsonDecode(res.body) as Map<String, dynamic>;
      final raw = (decoded['bars'] as Map<String, dynamic>?)?[symbol];
      final bars = (raw as List<dynamic>?) ?? const [];
      final candles = <MinuteCandle>[];
      for (var i = 0; i < bars.length; i++) {
        candles.add(
          AlpacaBarDto.fromJson(bars[i] as Map<String, dynamic>).toEntity(i),
        );
      }
      return candles;
    } catch (e) {
      throw MarketDataParseException('Unexpected Alpaca bars response: $e');
    }
  }

  @override
  Future<Map<String, double>> fetchLatestPrices(List<String> symbols) async {
    final uri = Uri.parse(
      '${ApiConfig.alpacaCryptoDataUrl}/latest/trades',
    ).replace(queryParameters: {'symbols': symbols.join(',')});

    final http.Response res;
    try {
      res = await _client.get(uri, headers: _headers);
    } catch (e) {
      throw NetworkException('Could not reach Alpaca: $e');
    }
    if (res.statusCode != 200) {
      throw MarketDataException('Alpaca latest HTTP ${res.statusCode}');
    }

    try {
      final decoded = jsonDecode(res.body) as Map<String, dynamic>;
      final trades = (decoded['trades'] as Map<String, dynamic>?) ?? const {};
      return {
        for (final entry in trades.entries)
          entry.key: ((entry.value as Map)['p'] as num).toDouble(),
      };
    } catch (e) {
      throw MarketDataParseException('Unexpected Alpaca latest response: $e');
    }
  }
}
