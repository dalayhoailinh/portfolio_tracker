import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../domain/entities/stock_model.dart';

class StockTile extends StatelessWidget {
  final StockModel stock;
  final VoidCallback? onTap;

  const StockTile({super.key, required this.stock, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isPositive = stock.changePercent > 0;
    final prefix = isPositive ? '+' : '';

    return GestureDetector(
      onTap: onTap,
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
                Text(stock.symbol, style: AppTextStyles.titleSmall),
                const SizedBox(height: 2),
                Text(stock.name, style: AppTextStyles.bodySmall),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${stock.price.toStringAsFixed(2)}',
                  style: AppTextStyles.titleSmall,
                ),
                const SizedBox(height: 2),
                Text(
                  '$prefix${stock.changePercent.toStringAsFixed(2)}%',
                  style: isPositive
                      ? AppTextStyles.labelPositive
                      : AppTextStyles.labelNegative,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
