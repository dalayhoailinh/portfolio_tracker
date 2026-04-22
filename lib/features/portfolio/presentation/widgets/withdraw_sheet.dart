import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../market/domain/entities/position.dart';
import '../../../market/data/providers/market_notifier.dart';
import '../../data/providers/portfolio_notifier.dart';

class WithdrawSheet extends ConsumerStatefulWidget {
  final Position position;
  const WithdrawSheet({super.key, required this.position});

  @override
  ConsumerState<WithdrawSheet> createState() => _WithdrawSheetState();
}

class _WithdrawSheetState extends ConsumerState<WithdrawSheet> {
  final _quantityController = TextEditingController();
  String? _errorText;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> _handleWithdraw() async {
    final qty = double.tryParse(_quantityController.text.trim());
    if (qty == null || qty <= 0) {
      setState(() => _errorText = 'Quantity must be greater than 0');
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorText = null;
    });

    try {
      final marketState = ref.read(marketProvider);
      final stock = marketState.stocks.firstWhere(
        (s) => s.symbol == widget.position.symbol,
        orElse: () => marketState.stocks.first,
      );
      final currentPrice = stock.price;

      await ref
          .read(portfolioProvider.notifier)
          .withdraw(
            symbol: widget.position.symbol,
            quantity: qty,
            currentPrice: currentPrice,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Withdrew ${qty.toStringAsFixed(2)} ${widget.position.symbol} '
            '@ \$${currentPrice.toStringAsFixed(2)}',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          backgroundColor: AppColors.success,
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      setState(() => _errorText = e.toString());
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final pos = widget.position;
    final marketState = ref.watch(marketProvider);
    final stock = marketState.stocks.firstWhere(
      (s) => s.symbol == pos.symbol,
      orElse: () => marketState.stocks.first,
    );
    final currentPrice = stock.price;
    final pnl = pos.unrealizedPnl(currentPrice);
    final isPositive = pnl > 0;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('Withdraw ${pos.symbol}', style: AppTextStyles.titleMedium),
            const SizedBox(height: 12),
            _InfoRow(label: 'Owned', value: pos.quantity.toStringAsFixed(2)),
            _InfoRow(
              label: 'Avg buy',
              value: '\$${pos.avgBuyPrice.toStringAsFixed(2)}',
            ),
            _InfoRow(
              label: 'Current',
              value: '\$${currentPrice.toStringAsFixed(2)}',
            ),
            _InfoRow(
              label: 'Open PnL',
              value:
                  '\$${pnl.toStringAsFixed(2)} (${pos.unrealizedPnlPercent(currentPrice).toStringAsFixed(2)}%)',
              valueStyle: isPositive
                  ? AppTextStyles.labelPositive
                  : AppTextStyles.labelNegative,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _quantityController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: 'Quantity to withdraw',
                hintStyle: AppTextStyles.bodyMedium,
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            if (_errorText != null) ...[
              const SizedBox(height: 8),
              Text(_errorText!, style: AppTextStyles.labelNegative),
            ],
            const SizedBox(height: 16),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _handleWithdraw,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.negativeGain,
                  disabledBackgroundColor: AppColors.negativeGain.withValues(
                    alpha: 0.4,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.textPrimary,
                        ),
                      )
                    : Text(
                        'Confirm Withdraw',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? valueStyle;

  const _InfoRow({required this.label, required this.value, this.valueStyle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodySmall),
          Text(value, style: valueStyle ?? AppTextStyles.titleSmall),
        ],
      ),
    );
  }
}
