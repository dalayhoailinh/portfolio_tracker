import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/animations/animated_number_text.dart';
import '../../../../core/widgets/animations/animated_pnl_text.dart';
import '../../../market/domain/entities/position.dart';

class PositionTile extends StatelessWidget {
  final Position position;
  final double currentPrice;
  final VoidCallback? onTap;

  const PositionTile({
    super.key,
    required this.position,
    required this.currentPrice,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final pnl = position.unrealizedPnl(currentPrice);
    final pnlPercent = position.unrealizedPnlPercent(currentPrice);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(position.symbol, style: AppTextStyles.titleSmall),
                const SizedBox(height: 2),
                Text(
                  'Qty: ${position.quantity.toStringAsFixed(2)} '
                  '@ \$${position.avgBuyPrice.toStringAsFixed(2)}',
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AnimatedNumberText(
                  value: position.marketValue(currentPrice),
                  prefix: '\$',
                  style: AppTextStyles.titleSmall,
                ),
                const SizedBox(height: 2),
                AnimatedPnlText(value: pnl, percent: pnlPercent),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
