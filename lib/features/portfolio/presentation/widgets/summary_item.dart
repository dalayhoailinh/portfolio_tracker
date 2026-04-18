import 'package:flutter/material.dart';

import '../../../../core/constants/app_text_styles.dart';

class SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle valueStyle;

  const SummaryItem({
    super.key,
    required this.label,
    required this.value,
    required this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.bodySmall),
        const SizedBox(height: 4),
        Text(value, style: valueStyle),
      ],
    );
  }
}
