import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';

class ShellPage extends StatelessWidget {
  final Widget child;
  const ShellPage({super.key, required this.child});

  static const _tab = ['/', '/market'];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final currentIndex = _tab.indexWhere(
      (tab) => location == tab || location.startsWith('$tab/'),
    );
    final safeIndex = currentIndex < 0 ? 0 : currentIndex;

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: safeIndex,
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        onTap: (index) {
          context.go(_tab[index]);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Market',
          ),
        ],
      ),
    );
  }
}
