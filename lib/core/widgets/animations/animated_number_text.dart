import 'package:flutter/material.dart';

class AnimatedNumberText extends StatelessWidget {
  final double value;
  final int decimals;
  final String prefix;
  final String suffix;
  final TextStyle? style;
  final Duration duration;
  final Curve curve;

  const AnimatedNumberText({
    super.key,
    required this.value,
    this.decimals = 2,
    this.prefix = '',
    this.suffix = '',
    this.style,
    this.duration = const Duration(milliseconds: 350),
    this.curve = Curves.easeOut,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: duration,
      curve: curve,
      tween: Tween<double>(end: value),
      builder: (context, animatedValue, _) {
        return Text(
          '$prefix${animatedValue.toStringAsFixed(decimals)}$suffix',
          style: style,
        );
      },
    );
  }
}
