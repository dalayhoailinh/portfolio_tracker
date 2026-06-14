import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/i_indicator_engine.dart';
import '../services/dart_indicator_engine.dart';
import '../services/rust_indicator_engine.dart';

final indicatorEngineProvider = Provider<IIndicatorEngine>((ref) {
  if (kIsWeb) return const DartIndicatorEngine();
  return const RustIndicatorEngine();
});
