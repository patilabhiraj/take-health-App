import 'package:flutter/material.dart';
import 'package:take_health/core/theme/app_colors.dart';

class LabInsightsCard extends StatelessWidget {
  final VoidCallback? onUploadReport;

  const LabInsightsCard({
    super.key,
    this.onUploadReport,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lab Insights',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: cs.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Biological markers',
                    style: TextStyle(
                      fontSize: 13,
                      color: cs.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: onUploadReport,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Row(
                  children: [
                    Text(
                      'UPLOAD',
                      style: TextStyle(
                        color: cs.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.add,
                      color: cs.primary,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // No Reports State
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40),
            decoration: BoxDecoration(
              color: context.cWarmSurface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: cs.surface,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.upload_file_outlined,
                    color: cs.primary,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'NO REPORTS',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: cs.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'ADD LAB REPORTS TO GET\nBIOLOGICAL INSIGHTS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: cs.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: onUploadReport,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cs.primary,
                    foregroundColor: cs.onPrimary,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'UPLOAD NOW',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Recommendation Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.cWarmSurface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.auto_awesome_outlined,
                  color: cs.primary,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'RECOMMENDATION',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: cs.onSurface,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Add details to unlock tailored insights.',
                        style: TextStyle(
                          fontSize: 13,
                          color: cs.onSurfaceVariant,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
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
