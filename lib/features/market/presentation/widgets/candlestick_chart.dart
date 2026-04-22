import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../domain/entities/minute_candle.dart';
import 'candlestick_painter.dart';

class CandlestickChart extends StatelessWidget {
  final List<MinuteCandle> candles;
  final double height;

  const CandlestickChart({super.key, required this.candles, this.height = 280});

  @override
  Widget build(BuildContext context) {
    if (candles.isEmpty) {
      return SizedBox(
        height: height,
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.hourglass_top_rounded,
                color: AppColors.textSecondary,
                size: 32,
              ),
              SizedBox(height: 8),
              Text('Collecting candles...', style: AppTextStyles.bodyMedium),
              SizedBox(height: 4),
              Text(
                'A new m1 candle will be added every minute.',
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      height: height,
      child: RepaintBoundary(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return CustomPaint(
              size: Size(constraints.maxWidth, height),
              painter: CandlestickPainter(data: candles),
              isComplex: true,
              willChange: true,
            );
          },
        ),
      ),
    );
  }
}
