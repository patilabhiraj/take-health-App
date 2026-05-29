import 'package:flutter/material.dart';
import 'package:take_health/core/theme/app_colors.dart';

class NutritionDietQualityCard extends StatelessWidget {
  final double todayHealthy;
  final double todayAverage;
  final double todayJunk;
  final double bioHealthy;
  final double bioAverage;
  final double bioJunk;

  const NutritionDietQualityCard({
    super.key,
    this.todayHealthy = 0.0,
    this.todayAverage = 1.0,
    this.todayJunk = 0.0,
    this.bioHealthy = 0.0,
    this.bioAverage = 1.0,
    this.bioJunk = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

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
          Row(
            children: [
              const Icon(Icons.auto_awesome,
                  color: Color(0xFFE9A832), size: 18),
              const SizedBox(width: 8),
              Text(
                'DIET QUALITY SCORE',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: cs.onSurface,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _QualityRow(
            label: "TODAY'S\nQUALITY",
            healthy: todayHealthy,
            average: todayAverage,
            junk: todayJunk,
          ),
          const SizedBox(height: 12),
          _QualityRow(
            label: 'OVERALL\nBIO TREND',
            healthy: bioHealthy,
            average: bioAverage,
            junk: bioJunk,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFBE6),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFFE58F)),
            ),
            child: Row(
              children: [
                const Icon(Icons.bolt, color: Color(0xFFE9A832), size: 16),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Track your first meal to unlock personalized biological fuel insights.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF7A5C00),
                      height: 1.4,
                    ),
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

class _QualityRow extends StatelessWidget {
  final String label;
  final double healthy;
  final double average;
  final double junk;

  const _QualityRow({
    required this.label,
    required this.healthy,
    required this.average,
    required this.junk,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    const healthyColor = Color(0xFF4CAF50);
    const junkColor = Color(0xFFE07A24);

    final healthyPct = (healthy * 100).round();
    final averagePct = (average * 100).round();
    final junkPct = (junk * 100).round();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  color: cs.primary,
                  letterSpacing: 0.4,
                  height: 1.3,
                ),
              ),
              const Spacer(),
              _ScoreChip(value: healthyPct, label: 'HEALTHY', color: healthyColor),
              const SizedBox(width: 8),
              _ScoreChip(value: averagePct, label: 'AVERAGE', color: cs.onSurfaceVariant),
              const SizedBox(width: 8),
              _ScoreChip(value: junkPct, label: 'JUNK', color: junkColor),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: SizedBox(
              height: 6,
              child: Row(
                children: [
                  if (healthyPct > 0)
                    Flexible(
                      flex: healthyPct,
                      fit: FlexFit.tight,
                      child: Container(color: healthyColor),
                    ),
                  if (averagePct > 0)
                    Flexible(
                      flex: averagePct,
                      fit: FlexFit.tight,
                      child: Container(
                          color: cs.onSurfaceVariant.withValues(alpha: 0.3)),
                    ),
                  if (junkPct > 0)
                    Flexible(
                      flex: junkPct,
                      fit: FlexFit.tight,
                      child: Container(color: junkColor),
                    ),
                  if (healthyPct == 0 && averagePct == 0 && junkPct == 0)
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                          color: cs.onSurfaceVariant.withValues(alpha: 0.2)),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScoreChip extends StatelessWidget {
  final int value;
  final String label;
  final Color color;

  const _ScoreChip({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '$value%',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.w600,
            color: color.withValues(alpha: 0.8),
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}
