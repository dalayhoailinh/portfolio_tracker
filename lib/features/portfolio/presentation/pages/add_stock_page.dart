import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../market/data/providers/market_notifier.dart';
import '../../../market/domain/entities/stock_model.dart';
import '../../data/providers/portfolio_notifier.dart';

class AddStockPage extends ConsumerStatefulWidget {
  const AddStockPage({super.key});

  @override
  ConsumerState<AddStockPage> createState() => _AddStockPageState();
}

class _AddStockPageState extends ConsumerState<AddStockPage> {
  final _searchController = TextEditingController();
  final _quantityController = TextEditingController();
  StockModel? _selectedStock;
  String _query = '';
  String? _errorText;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _searchController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  List<StockModel> _filter(List<StockModel> stocks) {
    if (_query.isEmpty) return stocks;
    final lower = _query.toLowerCase();
    return stocks
        .where(
          (s) =>
              s.symbol.toLowerCase().contains(lower) ||
              s.name.toLowerCase().contains(lower),
        )
        .toList();
  }

  Future<void> _handleBuy() async {
    final stock = _selectedStock;
    if (stock == null) return;

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
      await ref
          .read(portfolioProvider.notifier)
          .buy(stock: stock, quantity: qty);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Bought ${qty.toStringAsFixed(2)} ${stock.symbol} @ \$${stock.price.toStringAsFixed(2)}',
          ),
          backgroundColor: AppColors.success,
        ),
      );
      context.pop();
    } catch (e) {
      setState(() => _errorText = e.toString());
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final marketState = ref.watch(marketProvider);
    final portfolioState = ref.watch(portfolioProvider);
    final filtered = _filter(marketState.stocks);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Stock', style: AppTextStyles.titleLarge),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Cash available: \$${portfolioState.cash.toStringAsFixed(2)}',
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _searchController,
                onChanged: (v) => setState(() {
                  _query = v;
                  _selectedStock = null;
                }),
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: 'Search symbol or name',
                  hintStyle: AppTextStyles.bodyMedium,
                  filled: true,
                  fillColor: AppColors.surface,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.textSecondary,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Expanded(
                child: ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, i) {
                    final stock = filtered[i];
                    final isSelected = _selectedStock?.symbol == stock.symbol;
                    return GestureDetector(
                      onTap: () => setState(() {
                        _selectedStock = stock;
                        _quantityController.clear();
                        _errorText = null;
                      }),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.surfaceLight
                              : AppColors.surface,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.divider,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  stock.symbol,
                                  style: AppTextStyles.titleSmall,
                                ),
                                Text(
                                  stock.name,
                                  style: AppTextStyles.bodySmall,
                                ),
                              ],
                            ),
                            Text(
                              '\$${stock.price.toStringAsFixed(2)}',
                              style: AppTextStyles.titleSmall,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (_selectedStock != null) ...[
                const SizedBox(height: 12),
                TextField(
                  controller: _quantityController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Quantity',
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
                const SizedBox(height: 12),
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _isSubmitting ? null : _handleBuy,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      disabledBackgroundColor: AppColors.primary.withValues(
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
                            'Buy ${_selectedStock!.symbol}',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
