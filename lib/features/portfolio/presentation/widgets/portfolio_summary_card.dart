import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/animations/animated_number_text.dart';
import '../../domain/entities/portfolio_state.dart';
import 'summary_item.dart';

class PortfolioSummaryCard extends StatelessWidget {
  final PortfolioState portfolioState;
  final VoidCallback? onPressed;
  const PortfolioSummaryCard({
    super.key,
    required this.portfolioState,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Portfolio Summary', style: AppTextStyles.titleMedium),
              TextButton(onPressed: onPressed, child: Text('Reset')),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: SummaryItem(
                  label: 'Cash',
                  valueWidget: AnimatedNumberText(
                    value: portfolioState.cash,
                    prefix: '\$',
                    style: AppTextStyles.titleSmall,
                  ),
                ),
              ),
              Expanded(
                child: SummaryItem(
                  label: 'Equity',
                  valueWidget: AnimatedNumberText(
                    value: portfolioState.totalEquity,
                    prefix: '\$',
                    style: AppTextStyles.titleSmall,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: SummaryItem(
                  label: 'Realized PnL',
                  valueWidget: AnimatedNumberText(
                    value: portfolioState.realizedPnL,
                    prefix: '\$',
                    style: portfolioState.realizedPnL >= 0
                        ? AppTextStyles.labelPositive
                        : AppTextStyles.labelNegative,
                  ),
                ),
              ),
              Expanded(
                child: SummaryItem(
                  label: 'Unrealized PnL',
                  valueWidget: AnimatedNumberText(
                    value: portfolioState.unrealizedPnL,
                    prefix: '\$',
                    style: portfolioState.unrealizedPnL >= 0
                        ? AppTextStyles.labelPositive
                        : AppTextStyles.labelNegative,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
