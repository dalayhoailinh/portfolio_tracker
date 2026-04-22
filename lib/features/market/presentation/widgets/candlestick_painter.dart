import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/minute_candle.dart';

class CandlestickPainter extends CustomPainter {
  final List<MinuteCandle> data;

  const CandlestickPainter({required this.data});

  static const double _rightAxisWidth = 64;
  static const double _paddingTop = 16;
  static const double _paddingBottom = 8;

  void _drawPriceLabel(Canvas canvas, double price, Offset position) {
    final tp = TextPainter(
      text: TextSpan(
        text: price.toStringAsFixed(2),
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 10,
          fontWeight: FontWeight.w400,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout(maxWidth: _rightAxisWidth - 4);
    tp.paint(canvas, position);
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final chartWidth = size.width - _rightAxisWidth;
    final chartHeight = size.height - _paddingTop - _paddingBottom;
    final chartTop = _paddingTop;

    final rawMin = data.map((c) => c.low).reduce(min);
    final rawMax = data.map((c) => c.high).reduce(max);
    final rangePadding = (rawMax - rawMin) * 0.08;
    final displayMin = rawMin - rangePadding;
    final displayMax = rawMax + rangePadding;
    final priceRange = (displayMax - displayMin) == 0
        ? 1
        : (displayMax - displayMin);

    double priceToY(double price) =>
        chartTop + (displayMax - price) / priceRange * chartHeight;

    final columnWidth = chartWidth / data.length;
    final bodyWidth = (columnWidth * 0.6).clamp(2.0, 18.0);

    const int gridCount = 5;
    final gridPaint = Paint()
      ..color = AppColors.divider
      ..strokeWidth = 1;

    for (int g = 0; g <= gridCount; g++) {
      final y = chartTop + (g / gridCount) * chartHeight;
      canvas.drawLine(Offset(0, y), Offset(chartWidth, y), gridPaint);
      final price = displayMax - (g / gridCount) * (displayMax - displayMin);
      _drawPriceLabel(canvas, price, Offset(chartWidth, y - 7));
    }

    final bodyPaint = Paint();
    final wickPaint = Paint()..strokeWidth = 1;

    for (int i = 0; i < data.length; i++) {
      final candle = data[i];
      final isUp = candle.close >= candle.open;
      final color = isUp ? AppColors.positiveGain : AppColors.negativeGain;

      bodyPaint.color = color;
      wickPaint.color = color;

      final centerX = i * columnWidth + columnWidth / 2;
      final bodyLeft = centerX - bodyWidth / 2;

      final openY = priceToY(candle.open);
      final closeY = priceToY(candle.close);
      final bodyTop = min(openY, closeY);
      final bodyBottom = max(openY, closeY);
      final bodyHeight = (bodyBottom - bodyTop).clamp(1.0, double.infinity);

      canvas.drawLine(
        Offset(centerX, priceToY(candle.high)),
        Offset(centerX, bodyTop),
        wickPaint,
      );
      canvas.drawLine(
        Offset(centerX, bodyBottom),
        Offset(centerX, priceToY(candle.low)),
        wickPaint,
      );

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(bodyLeft, bodyTop, bodyWidth, bodyHeight),
          const Radius.circular(2),
        ),
        bodyPaint,
      );
    }
  }

  @override
  bool shouldRepaint(CandlestickPainter oldDelegate) {
    return oldDelegate.data != data;
  }
}
