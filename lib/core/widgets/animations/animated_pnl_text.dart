import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import 'animated_number_text.dart';

class AnimatedPnlText extends StatelessWidget {
  final double value;
  final double? percent;
  final TextStyle baseStyle;

  const AnimatedPnlText({
    super.key,
    required this.value,
    this.percent,
    this.baseStyle = AppTextStyles.labelPositive,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = value >= 0;
    final color = isPositive ? AppColors.positiveGain : AppColors.negativeGain;
    final prefix = isPositive ? '+' : '-';
    final absValue = value.abs();

    return AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 300),
      style: baseStyle.copyWith(color: color),
      child: percent == null
          ? AnimatedNumberText(
              value: absValue,
              prefix: '$prefix\$',
              style: baseStyle.copyWith(color: color),
            )
          : AnimatedNumberText(
              value: absValue,
              prefix: '$prefix\$',
              suffix: ' ($prefix${percent!.abs().toStringAsFixed(2)}%)',
              style: baseStyle.copyWith(color: color),
            ),
    );
  }
}
