import 'package:flutter/material.dart';
import 'package:take_health/core/theme/app_colors.dart';

class NutritionWeeklyTrendsCard extends StatelessWidget {
  final List<double> weeklyCalories;
  final int averageCalories;
  final double variation;

  const NutritionWeeklyTrendsCard({
    super.key,
    this.weeklyCalories = const [
      1500, 1800, 1600, 1700, 1900, 1750, 1600
    ],
    this.averageCalories = 1707,
    this.variation = -0.10,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final variationStr =
        '${variation >= 0 ? '+' : ''}${(variation * 100).toInt()}%';
    final variationColor =
        variation >= 0 ? AppColors.lightSuccess : const Color(0xFFE07A24);

    const days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    final maxVal = weeklyCalories.isEmpty
        ? 1.0
        : weeklyCalories.reduce((a, b) => a > b ? a : b);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: context.cShadow,
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly Trends',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 110,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(weeklyCalories.length, (i) {
                final ratio =
                    maxVal > 0 ? (weeklyCalories[i] / maxVal).clamp(0.05, 1.0) : 0.05;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: FractionallySizedBox(
                              heightFactor: ratio,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: cs.primary.withValues(alpha: 0.22),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          days[i],
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: cs.onSurfaceVariant,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AVERAGE',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: cs.onSurfaceVariant,
                      letterSpacing: 0.6,
                    ),
                  ),
                  Text(
                    '$averageCalories kcal',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: cs.onSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 32),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'VARIATION',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: cs.onSurfaceVariant,
                      letterSpacing: 0.6,
                    ),
                  ),
                  Text(
                    variationStr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: variationColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
