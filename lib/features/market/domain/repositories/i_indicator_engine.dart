abstract class IIndicatorEngine {
  Future<List<double?>> sma({
    required List<double> closes,
    required int window,
  });
}
