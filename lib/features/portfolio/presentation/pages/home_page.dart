import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
        ],
      ),
      body: const Center(child: Text('Home Page')),
    );
  }
}
