import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/minute_candle.dart';

part 'alpaca_bar_dto.freezed.dart';
part 'alpaca_bar_dto.g.dart';

@freezed
abstract class AlpacaBarDto with _$AlpacaBarDto {
  const AlpacaBarDto._();
  const factory AlpacaBarDto({
    @JsonKey(name: 'o') required double open,
    @JsonKey(name: 'h') required double high,
    @JsonKey(name: 'l') required double low,
    @JsonKey(name: 'c') required double close,
  }) = _AlpacaBarDto;

  factory AlpacaBarDto.fromJson(Map<String, Object?> json) =>
      _$AlpacaBarDtoFromJson(json);

  MinuteCandle toEntity(int index) => MinuteCandle(
    index: index,
    open: open,
    high: high,
    low: low,
    close: close,
  );
}
