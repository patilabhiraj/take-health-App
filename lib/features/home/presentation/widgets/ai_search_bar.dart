import 'package:flutter/material.dart';
import 'package:take_health/core/theme/app_colors.dart';

class AiSearchBar extends StatelessWidget {
  final VoidCallback onTap;
  final String hintText;

  const AiSearchBar({
    super.key,
    required this.onTap,
    this.hintText = "What should I eat for dinner?",
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(35),
          border: Border.all(color: cs.outline.withValues(alpha: 0.5)),
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
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                color: cs.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.smart_toy_outlined,
                color: cs.onPrimary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                hintText,
                style: TextStyle(
                  fontSize: 13,
                  color: cs.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.auto_awesome,
              color: cs.primary,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
