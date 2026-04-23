import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/animations/live_pulse.dart';
import '../../data/providers/aggregated_candles_provider.dart';
import '../../data/providers/market_notifier.dart';
import '../../domain/entities/market_timeframe.dart';
import '../widgets/candlestick_chart.dart';
import '../widgets/timeframe_selector.dart';

class ChartPage extends ConsumerStatefulWidget {
  final String symbol;

  const ChartPage({super.key, required this.symbol});

  @override
  ConsumerState<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends ConsumerState<ChartPage> {
  MarketTimeframe _selected = MarketTimeframe.m1;

  @override
  Widget build(BuildContext context) {
    final candles = ref.watch(
      aggregatedCandlesProvider((symbol: widget.symbol, timeframe: _selected)),
    );

    final marketState = ref.watch(marketProvider);
    final stock = marketState.stocks.firstWhere(
      (s) => s.symbol == widget.symbol,
      orElse: () => marketState.stocks.first,
    );
    final currentPrice = stock.price;
    final isPositive = stock.changePercent > 0;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: AppColors.textPrimary,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(stock.symbol, style: AppTextStyles.titleMedium),
            Text(stock.name, style: AppTextStyles.bodySmall),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${currentPrice.toStringAsFixed(2)}',
                  style: AppTextStyles.titleMedium,
                ),
                Text(
                  '${isPositive ? '+' : ''}${stock.changePercent.toStringAsFixed(2)}%',
                  style: isPositive
                      ? AppTextStyles.labelPositive
                      : AppTextStyles.labelNegative,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          TimeframeSelector(
            selected: _selected,
            onChanged: (tf) => setState(() => _selected = tf),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Live ', style: AppTextStyles.titleSmall),
                        LivePulse(),
                        Text(
                          ' ${_selected.label}',
                          style: AppTextStyles.titleSmall,
                        ),
                        const Spacer(),
                        Text(
                          '${candles.length} candles',
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.fromLTRB(12, 12, 4, 12),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        switchInCurve: Curves.easeOut,
                        switchOutCurve: Curves.easeIn,
                        child: CandlestickChart(
                          key: ValueKey(_selected),
                          candles: candles,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: const [
                        _LegendItem(
                          color: AppColors.positiveGain,
                          label: 'Up (close >= open)',
                        ),
                        SizedBox(width: 20),
                        _LegendItem(
                          color: AppColors.negativeGain,
                          label: 'Down (close < open)',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: AppTextStyles.bodySmall),
      ],
    );
  }
}
