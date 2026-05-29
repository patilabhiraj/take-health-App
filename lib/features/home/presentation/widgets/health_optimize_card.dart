import 'package:flutter/material.dart';
import 'package:take_health/core/theme/app_colors.dart';

class HealthOptimizeCard extends StatelessWidget {
  final VoidCallback? onCompleteProfile;
  final VoidCallback? onUploadReport;

  const HealthOptimizeCard({
    super.key,
    this.onCompleteProfile,
    this.onUploadReport,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      height: 185,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: const DecorationImage(
          image: NetworkImage(
            "https://images.unsplash.com/photo-1517836357463-d25dfeac3438",
          ),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: context.cShadow,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withValues(alpha: 0.3),
              Colors.black.withValues(alpha: 0.7),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white24),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.health_and_safety_outlined,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Optimize Your Health",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              "NEW",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Add details and lab reports to unlock wellness insights.",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    label: "Complete profile",
                    onTap: onCompleteProfile,
                    isPrimary: false,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _ActionButton(
                    label: "Upload report",
                    icon: Icons.upload_outlined,
                    onTap: onUploadReport,
                    isPrimary: true,
                    primaryColor: cs.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool isPrimary;
  final Color? primaryColor;

  const _ActionButton({
    required this.label,
    this.icon,
    this.onTap,
    this.isPrimary = false,
    this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: isPrimary ? (primaryColor ?? Colors.green) : Colors.transparent,
          border: isPrimary ? null : Border.all(color: Colors.white24),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: 16),
              const SizedBox(width: 5),
            ],
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
