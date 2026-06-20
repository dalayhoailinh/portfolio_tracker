import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/animations/animated_number_text.dart';
import '../../../../core/widgets/animations/price_flash.dart';
import '../../data/providers/live_price_provider.dart';
import '../../domain/entities/market_data_exception.dart';

class LivePricesPage extends ConsumerWidget {
  const LivePricesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pricesAsync = ref.watch(livePricesProvider);

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
        title: const Text(
          'Live crypto (Alpaca)',
          style: AppTextStyles.titleMedium,
        ),
      ),
      body: pricesAsync.when(
        loading: () => const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 12),
              Text(
                'Connecting to the live feed…',
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
        ),
        error: (e, _) => _ErrorView(
          message: e is MarketDataException
              ? e.message
              : 'Something went wrong.',
          onRetry: () => ref.invalidate(livePricesProvider),
        ),
        data: (prices) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            for (final symbol in kLiveSymbols)
              _PriceRow(symbol: symbol, price: prices[symbol]),
          ],
        ),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String symbol;
  final double? price; // null = not seen a trade for this symbol yet
  const _PriceRow({required this.symbol, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(symbol, style: AppTextStyles.titleMedium),
          if (price == null)
            const Text('…', style: AppTextStyles.bodySmall)
          else
            PriceFlash(
              value: price!,
              child: AnimatedNumberText(
                value: price!,
                prefix: '\$',
                style: AppTextStyles.titleMedium,
              ),
            ),
        ],
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
              color: AppColors.textSecondary,
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
