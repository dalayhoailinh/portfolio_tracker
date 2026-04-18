import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../data/providers/auth_notifier.dart';
import '../../domain/entities/auth_state.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final isLoading = authState == AuthState.loading;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.show_chart_rounded,
                size: 64,
                color: AppColors.primary,
              ),
              const SizedBox(height: 24),
              Text(
                'Welcome to',
                textAlign: TextAlign.center,
                style: AppTextStyles.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Portfolio Tracker',
                textAlign: TextAlign.center,
                style: AppTextStyles.displayLarge,
              ),
              const SizedBox(height: 48),
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          ref.read(authProvider.notifier).login();
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor: AppColors.primary.withValues(
                      alpha: 0.4,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.textPrimary,
                          ),
                        )
                      : Text(
                          'Login (Demo)',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'This is a demo login. No authentication is required.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
