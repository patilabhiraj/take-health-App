import 'package:flutter/material.dart';
import 'package:take_health/core/theme/app_colors.dart';

class ProfileLogoutButton extends StatelessWidget {
  final VoidCallback onTap;

  const ProfileLogoutButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout_rounded, color: cs.error, size: 20),
            const SizedBox(width: 8),
            Text(
              'Logout Account',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: cs.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
