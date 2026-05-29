import 'package:flutter/material.dart';
import 'package:take_health/core/theme/app_colors.dart';

class StepCounterCard extends StatelessWidget {
  final int stepsToday;
  final int caloriesBurned;
  final int targetCalories;
  final VoidCallback? onTap;

  const StepCounterCard({
    super.key,
    this.stepsToday = 0,
    this.caloriesBurned = 0,
    this.targetCalories = 7000,
    this.onTap,
  });

  double get _progress => targetCalories > 0 ? caloriesBurned / targetCalories : 0.0;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: cs.outline.withValues(alpha: 0.5)),
          boxShadow: [
            BoxShadow(
              color: context.cShadow,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: context.cInfo.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.show_chart,
                        color: context.cInfo,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PEDOMETER',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: cs.onSurfaceVariant,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'STEP COUNTER',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: cs.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: context.cSuccess,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.chevron_right,
                      color: cs.onSurfaceVariant,
                      size: 24,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Steps Count
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: cs.inverseSurface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      stepsToday.toString(),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: cs.onInverseSurface,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'STEPS TODAY',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: cs.onSurfaceVariant,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Calories Progress
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.cWarmSurface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.local_fire_department,
                    color: context.cWarning,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '$caloriesBurned CAL',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: context.cWarning,
                              ),
                            ),
                            Text(
                              '${(_progress * 100).toInt()}% OF ${(targetCalories / 1000).toStringAsFixed(0)}K',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: _progress,
                            backgroundColor: cs.outline,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              context.cWarning,
                            ),
                            minHeight: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
