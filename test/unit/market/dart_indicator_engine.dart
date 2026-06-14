import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_tracker/features/market/data/services/dart_indicator_engine.dart';

void main() {
  const engine = DartIndicatorEngine();

  test('window <= 0 returns all null', () {
    expect(engine.smaSync(closes: [1, 2, 3], window: 0), [null, null, null]);
  });

  test('window 3 skips first two bars', () {
    final out = engine.smaSync(closes: [1, 2, 3, 4, 5], window: 3);
    expect(out[0], isNull);
    expect(out[1], isNull);
    expect(out[2], closeTo(2.0, 1e-9));
    expect(out[3], closeTo(3.0, 1e-9));
    expect(out[4], closeTo(4.0, 1e-9));
  });

  test('parity with the Rust reference values', () {
    final closes = [
      170.80,
      171.95,
      172.50,
      173.00,
      173.60,
      174.80,
      175.40,
      176.10,
      176.85,
      177.55,
    ];
    final out = engine.smaSync(closes: closes, window: 5);
    for (final v in out.sublist(0, 4)) {
      expect(v, isNull);
    }
    expect(
      out[4],
      closeTo((170.80 + 171.95 + 172.50 + 173.00 + 173.60) / 5.0, 1e-9),
    );
    expect(
      out[9],
      closeTo((174.80 + 175.40 + 176.10 + 176.85 + 177.55) / 5.0, 1e-9),
    );
  });
}
