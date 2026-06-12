import '../entities/portfolio_state.dart';

abstract class IPortfolioRepository {
  Future<void> save(PortfolioState state);
  Future<PortfolioState?> load();
  Future<void> clear();
}
