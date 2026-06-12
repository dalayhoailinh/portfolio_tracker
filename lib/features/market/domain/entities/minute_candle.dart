import 'package:freezed_annotation/freezed_annotation.dart';

part 'minute_candle.freezed.dart';

@freezed
abstract class MinuteCandle with _$MinuteCandle {
  const factory MinuteCandle({
    required int index,
    required double open,
    required double high,
    required double low,
    required double close,
  }) = _MinuteCandle;
}
