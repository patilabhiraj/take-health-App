import 'package:flutter/material.dart';
import 'package:take_health/core/theme/app_colors.dart';

class NutritionDeficiencyCard extends StatelessWidget {
  final VoidCallback? onUploadReport;
  final VoidCallback? onViewDetails;

  const NutritionDeficiencyCard({
    super.key,
    this.onUploadReport,
    this.onViewDetails,
  });

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
              Row(
                children: [
                  Icon(
                    Icons.science_outlined,
                    color: cs.primary,
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Nutrition Deficiency',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: cs.onSurface,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: onViewDetails,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Row(
                  children: [
                    Text(
                      'DETAILED',
                      style: TextStyle(
                        color: cs.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward,
                      color: cs.primary,
                      size: 14,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // No Data State
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 50),
            decoration: BoxDecoration(
              color: context.cWarmSurface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: cs.surface,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.description_outlined,
                    color: cs.onSurfaceVariant,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'UPLOAD LAB REPORTS TO SEE\nNUTRITION INSIGHTS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: cs.onSurfaceVariant,
                    height: 1.6,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
