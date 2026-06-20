import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:portfolio_tracker/features/market/data/services/alpaca_crypto_history_source.dart';

void main() {
  test('parses bars into MinuteCandles (oldest -> newest)', () async {
    final client = MockClient(
      (_) async => http.Response(
        '{"bars":{"BTC/USD":['
        '{"t":"2026-06-20T06:00:00Z","o":67000,"h":67100,"l":66950,"c":67050},'
        '{"t":"2026-06-20T06:01:00Z","o":67050,"h":67080,"l":67000,"c":67010}'
        ']}}',
        200,
      ),
    );
    final source = AlpacaCryptoHistorySource(
      client: client,
      key: 'k',
      secret: 's',
    );

    final candles = await source.fetchRecentMinuteBars('BTC/USD');

    expect(candles, hasLength(2));
    expect(candles.first.open, 67000.0);
    expect(candles.last.close, 67010.0);
    expect(candles.last.index, 1);
  });

  test('empty bars map returns an empty list', () async {
    final client = MockClient((_) async => http.Response('{"bars":{}}', 200));
    final source = AlpacaCryptoHistorySource(
      client: client,
      key: 'k',
      secret: 's',
    );
    expect(await source.fetchRecentMinuteBars('BTC/USD'), isEmpty);
  });

  test('latest trades become a symbol -> price map', () async {
    final client = MockClient(
      (_) async => http.Response(
        '{"trades":{"BTC/USD":{"p":67000.5},"ETH/USD":{"p":3500}}}',
        200,
      ),
    );
    final source = AlpacaCryptoHistorySource(
      client: client,
      key: 'k',
      secret: 's',
    );

    final prices = await source.fetchLatestPrices(['BTC/USD', 'ETH/USD']);

    expect(prices['BTC/USD'], 67000.5);
    expect(prices['ETH/USD'], 3500.0);
  });
}
