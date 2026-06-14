import '../../domain/repositories/i_indicator_engine.dart';

class DartIndicatorEngine implements IIndicatorEngine {
  const DartIndicatorEngine();

  @override
  Future<List<double?>> sma({
    required List<double> closes,
    required int window,
  }) async {
    return smaSync(closes: closes, window: window);
  }

  List<double?> smaSync({required List<double> closes, required int window}) {
    if (window <= 0) return List<double?>.filled(closes.length, null);

    final out = List<double?>.filled(closes.length, null);
    var sum = 0.0;

    for (var i = 0; i < closes.length; i++) {
      sum += closes[i];
      if (i + 1 >= window) {
        if (i + 1 > window) sum -= closes[i - window];
        out[i] = sum / window;
      }
    }

    return out;
  }
}
