import 'package:flutter/material.dart';
import 'package:take_health/core/theme/app_colors.dart';

class ProfileMetricCard extends StatelessWidget {
  final Color iconBg;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;
  final String? valueSuffix;
  final String? subtitle;
  final Color? subtitleColor;
  final String? chip;

  const ProfileMetricCard({
    super.key,
    required this.iconBg,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
    this.valueSuffix,
    this.subtitle,
    this.subtitleColor,
    this.chip,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(20),
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
          Row(children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 18),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurface,
                ),
              ),
            ),
          ]),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: cs.onSurface,
                ),
              ),
              if (valueSuffix != null) ...[
                const SizedBox(width: 4),
                Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Text(
                    valueSuffix!,
                    style:
                        TextStyle(fontSize: 13, color: cs.onSurfaceVariant),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 4),
          if (subtitle != null)
            Text(
              subtitle!,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: subtitleColor ?? cs.onSurfaceVariant,
              ),
            ),
          if (chip != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: cs.surfaceContainerHighest.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: cs.outline.withValues(alpha: 0.3)),
              ),
              child: Text(
                chip!,
                style:
                    TextStyle(fontSize: 11, color: cs.onSurfaceVariant),
              ),
            ),
        ],
      ),
    );
  }
}
