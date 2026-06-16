import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/i_market_data_source.dart';
import '../services/eodhd_data_source.dart';

final marketDataSourceProvider = Provider<IMarketDataSource>((ref) {
  return EodhdDataSource();
});
