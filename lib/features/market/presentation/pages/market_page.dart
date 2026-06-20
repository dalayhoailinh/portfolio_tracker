import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/providers/market_notifier.dart';
import '../widgets/stock_tile.dart';

class MarketPage extends ConsumerWidget {
  const MarketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final marketState = ref.watch(marketProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Market'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(marketProvider.notifier).resetMarket(),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: marketState.stocks.length,
          itemBuilder: (context, index) {
            final stock = marketState.stocks[index];
            return StockTile(
              stock: stock,
              onTap: () {
                context.push('/chart/${stock.symbol}');
              },
            );
          },
        ),
      ),
    );
  }
}
