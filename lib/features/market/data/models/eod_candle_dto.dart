import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/minute_candle.dart';

part 'eod_candle_dto.freezed.dart';
part 'eod_candle_dto.g.dart';

@freezed
abstract class EodCandleDto with _$EodCandleDto {
  const EodCandleDto._();
  const factory EodCandleDto({
    required DateTime date,
    required double open,
    required double high,
    required double low,
    required double close,
  }) = _EodCandleDto;

  factory EodCandleDto.fromJson(Map<String, Object?> json) =>
      _$EodCandleDtoFromJson(json);

  MinuteCandle toEntity(int index) {
    return MinuteCandle(
      index: index,
      open: open,
      high: high,
      low: low,
      close: close,
    );
  }
}
