import '../entities/live_tick.dart';

abstract class ILivePriceSource {
  Stream<LiveTick> watchTrades(List<String> symbols);
}
