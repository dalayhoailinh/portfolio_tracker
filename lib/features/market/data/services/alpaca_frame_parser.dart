import 'dart:convert';

import '../../domain/entities/live_tick.dart';
import '../../domain/entities/market_data_exception.dart';

abstract final class AlpacaFrameParser {
  static List<LiveTick> parseTrades(String raw) {
    final List<dynamic> items;
    try {
      items = jsonDecode(raw) as List<dynamic>;
    } catch (e) {
      throw MarketDataParseException('Unexpected Alpaca frame: $e');
    }

    final ticks = <LiveTick>[];
    for (final item in items) {
      final map = item as Map<String, dynamic>;
      final type = map['T'];

      if (type == 'error') {
        throw LiveStreamException(
          'Alpaca refused the connection: ${map['msg']} '
          '(code ${map['code']}). Check your ALPACA_KEY / ALPACA_SECRET.',
        );
      }

      if (type == 't') {
        ticks.add(
          LiveTick(
            symbol: map['S'] as String,
            price: (map['p'] as num).toDouble(),
          ),
        );
      }
    }

    return ticks;
  }

  static bool isAuthenticated(String raw) {
    try {
      final items = jsonDecode(raw) as List<dynamic>;
      return items.any(
        (item) =>
            item is Map<String, dynamic> &&
            item['T'] == 'success' &&
            item['msg'] == 'authenticated',
      );
    } catch (_) {
      return false;
    }
  }
}
