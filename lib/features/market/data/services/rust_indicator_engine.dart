import '../../../../src/rust/api/indicators.dart' as rust;
import '../../domain/repositories/i_indicator_engine.dart';

class RustIndicatorEngine implements IIndicatorEngine {
  const RustIndicatorEngine();

  @override
  Future<List<double?>> sma({
    required List<double> closes,
    required int window,
  }) {
    return rust.simpleMovingAverage(prices: closes, window: window);
  }
}
