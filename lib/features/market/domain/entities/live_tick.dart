import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_tick.freezed.dart';

@freezed
abstract class LiveTick with _$LiveTick {
  const factory LiveTick({required String symbol, required double price}) =
      _LiveTick;
}
