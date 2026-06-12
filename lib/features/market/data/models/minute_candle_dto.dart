import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/minute_candle.dart';

part 'minute_candle_dto.freezed.dart';
part 'minute_candle_dto.g.dart';

@freezed
abstract class MinuteCandleDto with _$MinuteCandleDto {
  const MinuteCandleDto._();
  const factory MinuteCandleDto({
    required int index,
    required double open,
    required double high,
    required double low,
    required double close,
  }) = _MinuteCandleDto;

  factory MinuteCandleDto.fromJson(Map<String, dynamic> json) =>
      _$MinuteCandleDtoFromJson(json);

  factory MinuteCandleDto.fromEntity(MinuteCandle entity) {
    return MinuteCandleDto(
      index: entity.index,
      open: entity.open,
      high: entity.high,
      low: entity.low,
      close: entity.close,
    );
  }

  MinuteCandle toEntity() {
    return MinuteCandle(
      index: index,
      open: open,
      high: high,
      low: low,
      close: close,
    );
  }
}
