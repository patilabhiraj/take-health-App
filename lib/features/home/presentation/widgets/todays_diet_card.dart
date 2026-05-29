import 'package:flutter/material.dart';
import 'package:take_health/core/theme/app_colors.dart';

class TodaysDietCard extends StatefulWidget {
  final VoidCallback? onViewFullPlan;

  const TodaysDietCard({
    super.key,
    this.onViewFullPlan,
  });

  @override
  State<TodaysDietCard> createState() => _TodaysDietCardState();
}

class _TodaysDietCardState extends State<TodaysDietCard> {
  String selectedMeal = 'LUNCH';

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
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
              Text(
                "Today's Diet",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: cs.onSurface,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 16,
                    color: cs.onSurfaceVariant,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "Fri, 29 May 2026",
                    style: TextStyle(
                      fontSize: 13,
                      color: cs.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Meal Type Selector
          Row(
            children: [
              _MealTypeChip(
                label: 'BREAKFAST',
                isSelected: selectedMeal == 'BREAKFAST',
                onTap: () => setState(() => selectedMeal = 'BREAKFAST'),
              ),
              const SizedBox(width: 10),
              _MealTypeChip(
                label: 'LUNCH',
                isSelected: selectedMeal == 'LUNCH',
                onTap: () => setState(() => selectedMeal = 'LUNCH'),
              ),
              const SizedBox(width: 10),
              _MealTypeChip(
                label: 'DINNER',
                isSelected: selectedMeal == 'DINNER',
                onTap: () => setState(() => selectedMeal = 'DINNER'),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // No Plan State
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40),
            decoration: BoxDecoration(
              color: context.cWarmSurface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: cs.surface,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.restaurant_outlined,
                    color: cs.primary,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'NO PLAN TODAY',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: cs.onSurface,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // View Full Plan Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: widget.onViewFullPlan,
              style: ElevatedButton.styleFrom(
                backgroundColor: cs.primary,
                foregroundColor: cs.onPrimary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'View Full Plan',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MealTypeChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _MealTypeChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? cs.primary : cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: isSelected ? cs.onPrimary : cs.onSurfaceVariant,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
