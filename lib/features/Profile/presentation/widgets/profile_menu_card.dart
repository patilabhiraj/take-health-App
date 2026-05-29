import 'package:flutter/material.dart';
import 'package:take_health/core/theme/app_colors.dart';

class ProfileMenuItemData {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileMenuItemData({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}

class ProfileMenuCard extends StatelessWidget {
  final List<ProfileMenuItemData> items;

  const ProfileMenuCard({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
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
        children: List.generate(items.length * 2 - 1, (i) {
          if (i.isOdd) {
            return Divider(
              height: 1,
              indent: 68,
              color: cs.outline.withValues(alpha: 0.18),
            );
          }
          final index = i ~/ 2;
          final item = items[index];
          return _ProfileMenuItem(
            item: item,
            isFirst: index == 0,
            isLast: index == items.length - 1,
          );
        }),
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final ProfileMenuItemData item;
  final bool isFirst;
  final bool isLast;

  const _ProfileMenuItem({
    required this.item,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return InkWell(
      onTap: item.onTap,
      borderRadius: BorderRadius.vertical(
        top: isFirst ? const Radius.circular(22) : Radius.zero,
        bottom: isLast ? const Radius.circular(22) : Radius.zero,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(item.icon, size: 19, color: cs.onSurface),
          ),
          const SizedBox(width: 14),
          Text(
            item.title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: cs.onSurface,
            ),
          ),
          const Spacer(),
          Icon(Icons.chevron_right_rounded,
              size: 20, color: cs.onSurfaceVariant),
        ]),
      ),
    );
  }
}
