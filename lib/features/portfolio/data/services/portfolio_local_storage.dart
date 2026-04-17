import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/portfolio_state.dart';

class PortfolioLocalStorage {
  static const String _key = 'portfolio_state';

  Future<void> save(PortfolioState state) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(state.toJson()));
  }

  Future<PortfolioState?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return null;
    return PortfolioState.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
