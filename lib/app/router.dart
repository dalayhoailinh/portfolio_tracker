import 'package:go_router/go_router.dart';

import '../features/auth/presentation/pages/login_page.dart';
import '../features/chart/presentation/pages/chart_page.dart';
import '../features/portfolio/presentation/pages/add_stock_page.dart';
import '../features/portfolio/presentation/pages/home_page.dart';
import '../features/shell/presentation/pages/shell_page.dart';

final router = GoRouter(
  initialLocation: '/login',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    ShellRoute(
      builder: (context, state, child) => ShellPage(child: child),
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomePage()),
        GoRoute(path: '/chart', builder: (context, state) => const ChartPage()),
      ],
    ),
    GoRoute(path: '/add', builder: (context, state) => const AddStockPage()),
  ],
);
