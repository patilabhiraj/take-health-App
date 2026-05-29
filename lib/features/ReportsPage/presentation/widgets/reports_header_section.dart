import 'package:flutter/material.dart';

class ReportsHeaderSection extends StatelessWidget {
  const ReportsHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: cs.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.monitor_heart_outlined,
                      color: cs.primary, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    'Smart Lab Insights',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: cs.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'Upload your medical reports and let our AI translate complex jargon into actionable health insights and visualize your progress over time.',
          style: TextStyle(
            fontSize: 13,
            color: cs.onSurfaceVariant,
            height: 1.55,
          ),
        ),
      ],
    );
  }
}
