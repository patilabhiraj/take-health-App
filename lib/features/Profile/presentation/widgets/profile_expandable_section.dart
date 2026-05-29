import 'package:flutter/material.dart';
import 'package:take_health/core/theme/app_colors.dart';

class ProfileExpandableSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool expanded;
  final VoidCallback onToggle;
  final Widget child;

  const ProfileExpandableSection({
    super.key,
    required this.icon,
    required this.title,
    required this.expanded,
    required this.onToggle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return AnimatedSize(
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeInOut,
      alignment: Alignment.topCenter,
      child: Container(
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
          children: [
            InkWell(
              onTap: onToggle,
              borderRadius: expanded
                  ? const BorderRadius.vertical(top: Radius.circular(22))
                  : BorderRadius.circular(22),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
                child: Row(children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: cs.surfaceContainerHighest.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, size: 20, color: cs.onSurface),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: cs.onSurface,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    expanded
                        ? Icons.keyboard_arrow_down_rounded
                        : Icons.chevron_right_rounded,
                    color: cs.onSurfaceVariant,
                    size: 22,
                  ),
                ]),
              ),
            ),
            if (expanded) ...[
              Divider(
                  height: 1,
                  color: cs.outline.withValues(alpha: 0.18)),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                child: child,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
