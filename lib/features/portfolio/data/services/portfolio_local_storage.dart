import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/portfolio_state.dart';
import '../../domain/repositories/i_portfolio_repository.dart';
import '../models/portfolio_state_dto.dart';
import '../../../market/data/services/market_local_storage.dart';

class PortfolioLocalStorage implements IPortfolioRepository {
  static const String _key = 'portfolio_state';

  @override
  Future<void> save(PortfolioState state) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final dto = PortfolioStateDto.fromEntity(state);
      await prefs.setString(_key, jsonEncode(dto.toJson()));
    } catch (e) {
      throw LocalStorageException('Failed to save portfolio: $e');
    }
  }

  @override
  Future<PortfolioState?> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_key);
      if (raw == null) return null;
      final dto = PortfolioStateDto.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );
      return dto.toEntity();
    } catch (e) {
      throw LocalStorageException('Failed to load portfolio: $e');
    }
  }

  @override
  Future<void> clear() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_key);
    } catch (e) {
      throw LocalStorageException('Failed to clear portfolio: $e');
    }
  }
}
