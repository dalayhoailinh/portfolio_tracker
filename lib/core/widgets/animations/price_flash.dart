import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class PriceFlash extends StatefulWidget {
  final double value;
  final Widget child;
  final Duration duration;

  const PriceFlash({
    super.key,
    required this.value,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  State<PriceFlash> createState() => _PriceFlashState();
}

class _PriceFlashState extends State<PriceFlash>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late double _lastValue;
  Color _flashColor = Colors.transparent;

  @override
  void initState() {
    super.initState();
    _lastValue = widget.value;
    _controller = AnimationController(vsync: this, duration: widget.duration);
  }

  @override
  void didUpdateWidget(PriceFlash oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _flashColor = widget.value > _lastValue
          ? AppColors.positiveGain
          : AppColors.negativeGain;
      _lastValue = widget.value;
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final alpha = (1.0 - _controller.value) * 0.28;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: _flashColor.withValues(alpha: alpha),
            borderRadius: BorderRadius.circular(6),
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
