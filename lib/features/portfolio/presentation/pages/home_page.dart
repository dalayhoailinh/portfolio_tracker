import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../auth/data/providers/auth_notifier.dart';
import '../../../market/data/providers/market_notifier.dart';
import '../../data/providers/portfolio_notifier.dart';
import '../widgets/portfolio_summary_card.dart';
import '../widgets/position_list_entry.dart';
import '../widgets/position_tile.dart';
import '../widgets/withdraw_sheet.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portfolioState = ref.watch(portfolioProvider);
    final marketState = ref.watch(marketProvider);
    final positions = portfolioState.positions.values.toList();

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
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            PortfolioSummaryCard(
              portfolioState: portfolioState,
              onPressed: () {
                ref.read(portfolioProvider.notifier).resetPortfolio();
              },
            ),
            const SizedBox(height: 20),
            const Text('Positions', style: AppTextStyles.titleMedium),
            const SizedBox(height: 10),
            if (positions.isEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.divider),
                ),
                child: const Text(
                  'No positions yet. Tap + to buy your first stock.',
                  style: AppTextStyles.bodyMedium,
                ),
              )
            else
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                alignment: Alignment.topCenter,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeIn,
                  transitionBuilder: (child, anim) =>
                      FadeTransition(opacity: anim, child: child),
                  child: Column(
                    key: ValueKey(positions.map((p) => p.symbol).join('|')),
                    children: positions.map((pos) {
                      final stock = marketState.stocks.firstWhere(
                        (s) => s.symbol == pos.symbol,
                        orElse: () => marketState.stocks.first,
                      );
                      return PositionListEntry(
                        key: ValueKey(pos.symbol),
                        child: PositionTile(
                          position: pos,
                          currentPrice: stock.price,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) =>
                                  WithdrawSheet(position: pos),
                            );
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
