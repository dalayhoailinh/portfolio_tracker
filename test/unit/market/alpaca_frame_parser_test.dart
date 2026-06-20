import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_tracker/features/market/data/services/alpaca_frame_parser.dart';
import 'package:portfolio_tracker/features/market/domain/entities/market_data_exception.dart';

void main() {
  test('parses a trade frame into a LiveTick', () {
    const raw =
        '[{"T":"t","S":"BTC/USD","p":67000.5,"s":0.01,"t":"2026-01-01T00:00:00Z"}]';

    final ticks = AlpacaFrameParser.parseTrades(raw);
    expect(ticks, hasLength(1));
    expect(ticks.first.symbol, 'BTC/USD');
    expect(ticks.first.price, 67000.5);
  });

  test('integer price is read as a double', () {
    const raw = '[{"T":"t","S":"ETH/USD","p":3500}]';
    expect(AlpacaFrameParser.parseTrades(raw).first.price, 3500.0);
  });

  test('control frames produce no ticks', () {
    expect(
      AlpacaFrameParser.parseTrades('[{"T":"success","msg":"connected"}]'),
      isEmpty,
    );
    expect(
      AlpacaFrameParser.parseTrades(
        '[{"T":"subscription","trades":["BTC/USD"]}]',
      ),
      isEmpty,
    );
  });

  test('an error frame becomes a LiveStreamException', () {
    const raw = '[{"T":"error","code":402,"msg":"auth failed"}]';
    expect(
      () => AlpacaFrameParser.parseTrades(raw),
      throwsA(isA<LiveStreamException>()),
    );
  });

  test('garbage body becomes a MarketDataParseException', () {
    expect(
      () => AlpacaFrameParser.parseTrades('not json'),
      throwsA(isA<MarketDataParseException>()),
    );
  });

  test('isAuthenticated detects the authenticated success frame', () {
    expect(
      AlpacaFrameParser.isAuthenticated(
        '[{"T":"success","msg":"authenticated"}]',
      ),
      isTrue,
    );
    expect(
      AlpacaFrameParser.isAuthenticated('[{"T":"success","msg":"connected"}]'),
      isFalse,
    );
  });
}
