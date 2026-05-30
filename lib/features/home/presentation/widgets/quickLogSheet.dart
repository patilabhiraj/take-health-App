
import 'package:flutter/material.dart';

class QuickLogSheet extends StatelessWidget {
  final VoidCallback onAddMealTap;

  const QuickLogSheet({super.key, required this.onAddMealTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF1F5EE),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Quick Log',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0x1F4A9B6E),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'PRIMARY',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF4A9B6E),
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Add Meal + Medical Records
          Row(
            children: [
              Expanded(
                child: _QuickLogCard(
                  icon: Icons.restaurant_menu_rounded,
                  iconColor: const Color(0xFF4A9B6E),
                  iconBg: const Color(0xFFD6EDE2),
                  title: 'Add Meal',
                  subtitle: 'Daily intake',
                  onTap: onAddMealTap,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _QuickLogCard(
                  icon: Icons.verified_user_outlined,
                  iconColor: const Color(0xFF7B6FCD),
                  iconBg: const Color(0xFFE8E6F7),
                  title: 'Medical Records',
                  subtitle: 'Vault records',
                  onTap: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Progress Insights
          _BannerTile(
            icon: Icons.trending_up_rounded,
            iconColor: const Color(0xFF4A9B6E),
            iconBg: Colors.white,
            title: 'Progress Insights',
            subtitle: 'Review vitality metrics',
            onTap: () => Navigator.of(context).pop(),
          ),
          const SizedBox(height: 20),

          // Section label
          const Text(
            'TRACK YOUR DAILY ACTIVITIES',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Color(0xFF888888),
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 12),

          // Activity grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.6,
            children: [
              _ActivityTile(
                icon: Icons.balance_outlined,
                iconColor: const Color(0xFF4A9B6E),
                iconBg: const Color(0xFFD6EDE2),
                label: 'Weight',
                onTap: () => Navigator.of(context).pop(),
              ),
              _ActivityTile(
                icon: Icons.local_drink_outlined,
                iconColor: const Color(0xFF5B9BD5),
                iconBg: const Color(0xFFD9EBF9),
                label: 'Water',
                onTap: () => Navigator.of(context).pop(),
              ),
              _ActivityTile(
                icon: Icons.bedtime_outlined,
                iconColor: const Color(0xFF7B6FCD),
                iconBg: const Color(0xFFE8E6F7),
                label: 'Sleep',
                onTap: () => Navigator.of(context).pop(),
              ),
              _ActivityTile(
                icon: Icons.directions_walk_rounded,
                iconColor: const Color(0xFFE8873A),
                iconBg: const Color(0xFFFAEAD9),
                label: 'Steps',
                onTap: () => Navigator.of(context).pop(),
              ),
              _ActivityTile(
                icon: Icons.air_rounded,
                iconColor: const Color(0xFFE8736E),
                iconBg: const Color(0xFFFADDDC),
                label: 'Smoke',
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickLogCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _QuickLogCard({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Material(
      color: cs.surface,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(
                  color: cs.onSurface,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: cs.onSurfaceVariant,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BannerTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _BannerTile({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: cs.onSurface,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: cs.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: cs.onSurfaceVariant,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String label;
  final VoidCallback onTap;

  const _ActivityTile({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  color: cs.onSurface,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
