import 'package:flutter/material.dart';
import 'package:take_health/core/theme/app_colors.dart';

class NutritionMealSection extends StatelessWidget {
  final DateTime date;
  final int breakfastConsumed;
  final int breakfastGoal;
  final int lunchConsumed;
  final int lunchGoal;
  final int dinnerConsumed;
  final int dinnerGoal;
  final VoidCallback? onAddBreakfast;
  final VoidCallback? onAddLunch;
  final VoidCallback? onAddDinner;

  const NutritionMealSection({
    super.key,
    required this.date,
    this.breakfastConsumed = 0,
    this.breakfastGoal = 540,
    this.lunchConsumed = 0,
    this.lunchGoal = 720,
    this.dinnerConsumed = 0,
    this.dinnerGoal = 540,
    this.onAddBreakfast,
    this.onAddLunch,
    this.onAddDinner,
  });

  String _formatDate(DateTime d) {
    const months = [
      'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
      'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'
    ];
    return 'TODAY, ${d.day} ${months[d.month - 1]} ${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              _formatDate(date),
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: cs.onSurface,
                letterSpacing: 0.3,
              ),
            ),
            const Spacer(),
            Icon(Icons.calendar_today_outlined,
                size: 18, color: cs.onSurfaceVariant),
          ],
        ),
        const SizedBox(height: 14),
        _MealCard(
          icon: Icons.coffee_outlined,
          label: 'Breakfast',
          consumed: breakfastConsumed,
          goal: breakfastGoal,
          onAdd: onAddBreakfast,
        ),
        const SizedBox(height: 10),
        _MealCard(
          icon: Icons.restaurant_outlined,
          label: 'Lunch',
          consumed: lunchConsumed,
          goal: lunchGoal,
          onAdd: onAddLunch,
        ),
        const SizedBox(height: 10),
        _MealCard(
          icon: Icons.dinner_dining_outlined,
          label: 'Dinner',
          consumed: dinnerConsumed,
          goal: dinnerGoal,
          onAdd: onAddDinner,
        ),
      ],
    );
  }
}

class _MealCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final int consumed;
  final int goal;
  final VoidCallback? onAdd;

  const _MealCard({
    required this.icon,
    required this.label,
    required this.consumed,
    required this.goal,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: context.cShadow,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.lightWarning.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.lightWarning, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: cs.onSurface,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$consumed',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: cs.primary,
                ),
              ),
              Text(
                'OF $goal KCAL',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurfaceVariant,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: onAdd,
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: cs.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
