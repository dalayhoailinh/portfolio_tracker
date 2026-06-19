import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:portfolio_tracker/features/market/data/services/eodhd_data_source.dart';
import 'package:portfolio_tracker/features/market/domain/entities/market_data_exception.dart';

void main() {
  test('200 + good JSON -> list of candles', () async {
    final client = MockClient((req) async {
      return http.Response(
        '[{"date":"2024-01-02","open":185.0,"high":188.0,"low":184.0,'
        '"close":187.0,"adjusted_close":186.5,"volume":1000}]',
        200,
      );
    });
    final source = EodhdDataSource(client: client, apiKey: 'demo');

    final candles = await source.fetchDailyCandles('AAPL');
    expect(candles, hasLength(1));
    expect(candles.first.close, 187.0);
    expect(candles.first.index, 0);
  });

  test('403 -> ApiKeyException', () async {
    final client = MockClient((req) async => http.Response('Forbidden', 403));
    final source = EodhdDataSource(client: client, apiKey: 'bad');

    expect(
      () async => await source.fetchDailyCandles('AAPL'),
      throwsA(isA<ApiKeyException>()),
    );
  });

  test('200 but garbage body → MarketDataParseException', () async {
    final client = MockClient((req) async => http.Response('not json', 200));
    final source = EodhdDataSource(client: client, apiKey: 'demo');

    expect(
      () => source.fetchDailyCandles('AAPL'),
      throwsA(isA<MarketDataParseException>()),
    );
  });
}
