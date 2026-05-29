import 'package:flutter/material.dart';
import 'package:take_health/core/theme/app_colors.dart';

class NutritionRecentFrequentCard extends StatelessWidget {
  final List<String> recentFoods;
  final List<String> frequentFoods;

  const NutritionRecentFrequentCard({
    super.key,
    this.recentFoods = const [],
    this.frequentFoods = const ['Oats', 'Eggs', 'Rice'],
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _FoodSection(
            title: 'Recent',
            foods: recentFoods,
            cs: cs,
            shadow: context.cShadow,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _FoodSection(
            title: 'Frequent',
            foods: frequentFoods,
            cs: cs,
            shadow: context.cShadow,
          ),
        ),
      ],
    );
  }
}

class _FoodSection extends StatelessWidget {
  final String title;
  final List<String> foods;
  final ColorScheme cs;
  final Color shadow;

  const _FoodSection({
    required this.title,
    required this.foods,
    required this.cs,
    required this.shadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: shadow, blurRadius: 10, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 10),
          if (foods.isEmpty)
            Text(
              'No ${title.toLowerCase()} items',
              style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
            )
          else
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: foods
                  .map(
                    (f) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: cs.surfaceContainerHighest.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: cs.outline.withValues(alpha: 0.35)),
                      ),
                      child: Text(
                        f,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: cs.onSurface,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}
