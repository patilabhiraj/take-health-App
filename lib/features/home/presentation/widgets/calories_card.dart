import 'package:flutter/material.dart';
import 'package:take_health/core/theme/app_colors.dart';

class CaloriesCard extends StatelessWidget {
  final int currentCalories;
  final int targetCalories;
  final int protein;
  final int carbs;
  final int fats;
  final VoidCallback? onViewDetails;

  const CaloriesCard({
    super.key,
    this.currentCalories = 0,
    this.targetCalories = 3335,
    this.protein = 18,
    this.carbs = 68,
    this.fats = 9,
    this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: cs.outline),
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
          Text(
            "Calories",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "DAILY TRACKING",
            style: TextStyle(
              color: cs.onSurfaceVariant,
              fontWeight: FontWeight.w600,
              fontSize: 10,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                Text(
                  "$currentCalories",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: cs.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "OF $targetCalories",
                  style: TextStyle(
                    color: cs.onSurfaceVariant,
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            decoration: BoxDecoration(
              color: context.cWarmSurface,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NutrientItem(
                  icon: Icons.water_drop_outlined,
                  iconColor: AppColors.protein,
                  value: "${protein}g",
                  label: "PROTEIN",
                ),
                NutrientItem(
                  icon: Icons.favorite_border,
                  iconColor: AppColors.carbs,
                  value: "${carbs}g",
                  label: "CARBS",
                ),
                NutrientItem(
                  icon: Icons.sentiment_satisfied_alt,
                  iconColor: AppColors.fats,
                  value: "${fats}g",
                  label: "FATS",
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const Divider(height: 1),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: onViewDetails,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Nutrient Info",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: cs.onSurface,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "View Details",
                      style: TextStyle(
                        color: cs.primary,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 10,
                      color: cs.primary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NutrientItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  const NutrientItem({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(icon, color: iconColor, size: 16),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: cs.onSurface,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: cs.onSurfaceVariant,
                fontSize: 7,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
