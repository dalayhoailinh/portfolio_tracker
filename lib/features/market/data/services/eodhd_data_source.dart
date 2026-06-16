import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../app/api_config.dart';
import '../../domain/entities/market_data_exception.dart';
import '../../domain/entities/minute_candle.dart';
import '../../domain/repositories/i_market_data_source.dart';
import '../models/eod_candle_dto.dart';

class EodhdDataSource implements IMarketDataSource {
  final http.Client _client;
  final String _apiKey;

  EodhdDataSource({http.Client? client, String? apiKey})
    : _client = client ?? http.Client(),
      _apiKey = apiKey ?? ApiConfig.eodhdApiKey;

  @override
  Future<List<MinuteCandle>> fetchDailyCandles(String symbol) async {
    final ticker = '$symbol.US';
    final from = DateTime.now()
        .subtract(const Duration(days: 280))
        .toIso8601String()
        .split('T')
        .first;

    final uri = Uri.parse(
      '${ApiConfig.eodhdBaseUrl}/eod/$ticker'
      '?api_token=$_apiKey&fmt=json&period=d&order=a&from=$from',
    );

    final http.Response response;
    try {
      response = await _client.get(uri);
    } catch (e) {
      throw NetworkException('Could not reach EODHD: $e');
    }

    if (response.statusCode == 401 || response.statusCode == 403) {
      throw ApiKeyException(symbol);
    }

    if (response.statusCode != 200) {
      throw MarketDataException(
        'EODHD returned HTTP ${response.statusCode} for $ticker',
      );
    }

    try {
      final decoded = jsonDecode(response.body);
      final candles = <MinuteCandle>[];
      for (var i = 0; i < decoded.length; i++) {
        final dto = EodCandleDto.fromJson(decoded[i] as Map<String, dynamic>);
        candles.add(dto.toEntity(i));
      }
      return candles;
    } catch (e) {
      throw MarketDataException('Unexpected EODHD response: $e');
    }
  }
}
