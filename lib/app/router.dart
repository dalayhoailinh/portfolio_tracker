import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/data/providers/router_notifier.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/market/presentation/pages/market_page.dart';
import '../features/portfolio/presentation/pages/add_stock_page.dart';
import '../features/portfolio/presentation/pages/home_page.dart';
import '../features/shell/presentation/pages/shell_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = ref.watch(routerNotifierProvider.notifier);

  return GoRouter(
    initialLocation: '/login',
    debugLogDiagnostics: true,
    refreshListenable: notifier,
    redirect: (context, state) => notifier.redirect(state),
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      ShellRoute(
        builder: (context, state, child) => ShellPage(child: child),
        routes: [
          GoRoute(path: '/', builder: (context, state) => const HomePage()),
          GoRoute(
            path: '/market',
            builder: (context, state) => const MarketPage(),
          ),
        ],
      ),
      GoRoute(path: '/add', builder: (context, state) => const AddStockPage()),
    ],
  );
});
