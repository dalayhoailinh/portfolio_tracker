import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_tracker/features/market/data/models/eod_candle_dto.dart';

void main() {
  test('fromJson parses one EODHD row and ignores extra fields', () {
    final json = {
      'date': '2024-01-02',
      'open': 187.15,
      'high': 188.44,
      'low': 183.88,
      'close': 185.64,
      'adjusted_close': 184.9, // extra → ignored
      'volume': 82488700, // extra → ignored
    };

    final dto = EodCandleDto.fromJson(json);
    expect(dto.close, 185.64);

    final candle = dto.toEntity(7);
    expect(candle.index, 7);
    expect(candle.open, 187.15);
    expect(candle.high, 188.44);
  });

  test('integer prices are accepted as doubles', () {
    final dto = EodCandleDto.fromJson({
      'date': '2024-01-03',
      'open': 170,
      'high': 171,
      'low': 169,
      'close': 170,
    });

    expect(dto.open, 170.0);
  });
}
