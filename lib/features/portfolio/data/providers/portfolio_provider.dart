import 'package:flutter_riverpod/legacy.dart';

import '../../domain/entities/portfolio_state.dart';
import '../services/portfolio_local_storage.dart';

class PortfolioProvider extends StateNotifier<PortfolioState> {
  final PortfolioLocalStorage _storage;

  PortfolioProvider({required PortfolioLocalStorage storage})
    : _storage = storage,
      super(PortfolioState.initial) {
    _init();
  }

  Future<void> _init() async {
    final saved = await _storage.load();
    if (saved != null) state = saved;
  }

  Future<void> resetPortfolio() async {
    state = PortfolioState.initial;
    await _storage.clear();
  }

  Future<void> setUnrealizedPnl(double value) async {
    state = state.copyWith(unrealizedPnL: value);
    await _storage.save(state);
  }

  Future<void> setRealizedPnl(double value) async {
    state = state.copyWith(realizedPnL: value);
    await _storage.save(state);
  }
}

final portfolioProvider =
    StateNotifierProvider<PortfolioProvider, PortfolioState>(
      (ref) => PortfolioProvider(storage: PortfolioLocalStorage()),
    );
