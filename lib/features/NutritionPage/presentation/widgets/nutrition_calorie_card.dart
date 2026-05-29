import 'package:flutter/material.dart';
import 'package:take_health/core/theme/app_colors.dart';

class NutritionCalorieCard extends StatelessWidget {
  final int consumed;
  final int goal;
  final int proteinConsumed;
  final int proteinGoal;
  final int carbsConsumed;
  final int carbsGoal;
  final int fatsConsumed;
  final int fatsGoal;

  const NutritionCalorieCard({
    super.key,
    this.consumed = 0,
    this.goal = 1800,
    this.proteinConsumed = 0,
    this.proteinGoal = 70,
    this.carbsConsumed = 0,
    this.carbsGoal = 200,
    this.fatsConsumed = 0,
    this.fatsGoal = 55,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final percent = goal > 0 ? (consumed / goal * 100).clamp(0.0, 100.0) : 0.0;
    final remaining = goal - consumed;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
            'Daily Calorie Intake',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$consumed',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: cs.onSurface,
                        height: 1,
                      ),
                    ),
                    TextSpan(
                      text: ' / $goal',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${percent.toInt()}%',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: cs.onSurface,
                    ),
                  ),
                  Text(
                    'OF GOAL',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: cs.onSurfaceVariant,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: percent / 100,
              backgroundColor: cs.surfaceContainerHighest,
              color: cs.primary,
              minHeight: 7,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$remaining kcal remaining',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: cs.primary,
            ),
          ),
          const SizedBox(height: 18),
          const Divider(height: 1),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _MacroItem(
                label: 'PROTEIN',
                consumed: proteinConsumed,
                goal: proteinGoal,
                color: AppColors.protein,
              ),
              Container(width: 1, height: 44, color: AppColors.lightBorder),
              _MacroItem(
                label: 'CARBS',
                consumed: carbsConsumed,
                goal: carbsGoal,
                color: AppColors.carbs,
              ),
              Container(width: 1, height: 44, color: AppColors.lightBorder),
              _MacroItem(
                label: 'FATS',
                consumed: fatsConsumed,
                goal: fatsGoal,
                color: AppColors.fats,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MacroItem extends StatelessWidget {
  final String label;
  final int consumed;
  final int goal;
  final Color color;

  const _MacroItem({
    required this.label,
    required this.consumed,
    required this.goal,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final ratio = goal > 0 ? (consumed / goal).clamp(0.0, 1.0) : 0.0;

    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w700,
            color: cs.onSurfaceVariant,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 7),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '${consumed}g',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: cs.onSurface,
                ),
              ),
              TextSpan(
                text: ' / ${goal}g',
                style: TextStyle(
                  fontSize: 11,
                  color: cs.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 7),
        SizedBox(
          width: 64,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: ratio,
              backgroundColor: color.withValues(alpha: 0.15),
              color: color,
              minHeight: 5,
            ),
          ),
        ),
      ],
    );
  }
}
