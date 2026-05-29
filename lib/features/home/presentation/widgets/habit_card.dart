import 'package:flutter/material.dart';
import 'package:take_health/core/theme/app_colors.dart';

class HabitCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBackgroundColor;
  final Color iconColor;
  final String statusText;
  final String? statusEmoji;
  final String? description;
  final VoidCallback? onTap;

  const HabitCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconColor,
    required this.statusText,
    this.statusEmoji,
    this.description,
    this.onTap,
  });

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
                        color: iconBackgroundColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        icon,
                        color: iconColor,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subtitle.toUpperCase(),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: cs.onSurfaceVariant,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          title,
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
                Icon(
                  Icons.chevron_right,
                  color: cs.onSurfaceVariant,
                  size: 24,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Status
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
                      '0',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: cs.onInverseSurface,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    statusEmoji != null ? '$statusText $statusEmoji' : statusText,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: cs.onSurfaceVariant,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ],
            ),

            if (description != null) ...[
              const SizedBox(height: 16),
              Text(
                description!,
                style: TextStyle(
                  fontSize: 13,
                  color: cs.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Predefined Habit Cards
class SmokeLogCard extends StatelessWidget {
  final VoidCallback? onTap;

  const SmokeLogCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return HabitCard(
      title: 'SMOKE LOG',
      subtitle: 'HABIT',
      icon: Icons.air,
      iconBackgroundColor: context.cPrimarySurface,
      iconColor: Theme.of(context).colorScheme.primary,
      statusText: 'SMOKE FREE TODAY',
      statusEmoji: '🌿',
      description: 'Log daily to see your trend',
      onTap: onTap,
    );
  }
}

class DrinkLogCard extends StatelessWidget {
  final VoidCallback? onTap;

  const DrinkLogCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return HabitCard(
      title: 'DRINK LOG',
      subtitle: 'AWARENESS',
      icon: Icons.local_drink_outlined,
      iconBackgroundColor: context.cInfo.withValues(alpha: 0.1),
      iconColor: context.cInfo,
      statusText: 'NONE LOGGED TODAY',
      description: 'Tap to start logging',
      onTap: onTap,
    );
  }
}
