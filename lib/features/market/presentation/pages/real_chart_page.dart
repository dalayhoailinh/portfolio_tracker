import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../data/providers/daily_candles_provider.dart';
import '../../domain/entities/market_data_exception.dart';
import '../widgets/candlestick_chart.dart';

class RealChartPage extends ConsumerWidget {
  final String symbol;
  const RealChartPage({super.key, required this.symbol});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final candlesAsync = ref.watch(dailyCandlesProvider(symbol));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: AppColors.textPrimary,
          ),
        ),
        title: Text(
          '$symbol - real daily (EODHD)',
          style: AppTextStyles.titleMedium,
        ),
      ),
      body: candlesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => _ErrorView(
          message: e is MarketDataException
              ? e.message
              : 'Something went wrong.',
          onRetry: () => ref.invalidate(dailyCandlesProvider(symbol)),
        ),
        data: (candles) {
          if (candles.isEmpty) {
            return const Center(
              child: Text(
                'No data for this symbol.',
                style: AppTextStyles.bodySmall,
              ),
            );
          }

          final visible = candles.length > 90
              ? candles.sublist(candles.length - 90)
              : candles;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${visible.length} real daily candles',
                  style: AppTextStyles.bodySmall,
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.fromLTRB(12, 12, 4, 12),
                  child: CandlestickChart(candles: visible),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.cloud_off_rounded,
              color: AppColors.error,
              size: 48,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall,
            ),
            const SizedBox(height: 16),
            FilledButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
