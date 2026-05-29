import 'package:flutter/material.dart';

class DietPlanPage extends StatelessWidget {
  const DietPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.apple_outlined,
            size: 80,
            color: cs.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Personalized Diet Plan',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Coming Soon',
            style: TextStyle(
              color: cs.onSurfaceVariant,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
