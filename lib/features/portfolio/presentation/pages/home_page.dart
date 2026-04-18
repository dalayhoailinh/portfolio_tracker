import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../auth/data/providers/auth_notifier.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home', style: AppTextStyles.titleLarge),
        actions: [
          IconButton(
            onPressed: () {
              context.push('/add');
            },
            icon: const Icon(Icons.add, color: AppColors.textPrimary),
            tooltip: 'Add Stock',
          ),
          IconButton(
            icon: const Icon(
              Icons.logout_rounded,
              color: AppColors.negativeGain,
            ),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
            },
          ),
        ],
      ),
      body: const Center(child: Text('Home Page')),
    );
  }
}
