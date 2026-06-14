import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../data/providers/indicator_engine_provider.dart';
import '../../data/services/dart_indicator_engine.dart';

class BenchmarkPage extends ConsumerStatefulWidget {
  const BenchmarkPage({super.key});

  @override
  ConsumerState<BenchmarkPage> createState() => _BenchmarkPageState();
}

class _BenchmarkPageState extends ConsumerState<BenchmarkPage> {
  final List<String> _lines = [];
  bool _running = false;

  List<double> _syntheticPrices(int count) {
    final random = Random(42);
    var price = 100.0;
    return List.generate(count, (_) {
      price *= (random.nextDouble() - 0.5) * 0.002;
      return price;
    });
  }

  Future<void> _run() async {
    setState(() {
      _running = true;
      _lines.clear();
    });

    const dartEngine = DartIndicatorEngine();
    final engine = ref.watch(indicatorEngineProvider);

    // Round 1 - batch sizes: who wins at which scale?
    for (final count in [10000, 100000]) {
      final prices = _syntheticPrices(count);

      final dartWatch = Stopwatch()..start();
      dartEngine.smaSync(closes: prices, window: 20);
      dartWatch.stop();

      final rustWatch = Stopwatch()..start();
      await engine.sma(closes: prices, window: 20);
      rustWatch.stop();

      _lines.add(
        'SMA-20 on $count prices\n'
        '  Dart: ${dartWatch.elapsedMicroseconds} us   '
        'Rust: ${rustWatch.elapsedMicroseconds} us',
      );
      setState(() {});
    }

    // Round 2 = same total work, different call shape
    final small = _syntheticPrices(50);
    final dartPerCall = Stopwatch()..start();
    for (var i = 0; i < 1000; i++) {
      await dartEngine.sma(closes: small, window: 20);
    }
    dartPerCall.stop();

    final rustPerCall = Stopwatch()..start();
    for (var i = 0; i < 1000; i++) {
      await engine.sma(closes: small, window: 20);
    }
    rustPerCall.stop();

    final big = _syntheticPrices(50000);
    final dartBatch = Stopwatch()..start();
    await dartEngine.sma(closes: big, window: 20);
    dartBatch.stop();

    final rustBatch = Stopwatch()..start();
    await engine.sma(closes: big, window: 20);
    rustBatch.stop();

    _lines.add(
      'Same work, different shape (50,000 prices total)\n'
      'dart  1000 calls x 50 prices: ${dartPerCall.elapsedMicroseconds} us\n'
      'rust  1000 calls x 50 prices: ${rustPerCall.elapsedMicroseconds} us\n'
      'dart  1 call x 50,000 prices: ${dartBatch.elapsedMicroseconds} us\n'
      'rust  1 call x 50,000 prices: ${rustBatch.elapsedMicroseconds} us\n'
      '  The gap is pure bridge overhead. Batch, not per-call.',
    );

    setState(() => _running = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Rust vs Dart benchmark',
          style: AppTextStyles.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FilledButton(
              onPressed: _running ? null : _run,
              child: Text(_running ? 'Running...' : 'Run benchmark'),
            ),
            const SizedBox(height: 8),
            const Text(
              'Debug-mode numbers are NOT honest. For the README, run:\n'
              'flutter run --release -d windows',
              style: AppTextStyles.bodySmall,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  for (final line in _lines)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        line,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontFamily: 'monospace',
                          fontSize: 13,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
