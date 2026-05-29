import 'package:flutter/material.dart';
import 'package:take_health/core/theme/app_colors.dart';

class ReportsComparativeCard extends StatelessWidget {
  final List<String> selectedReports;
  final VoidCallback? onSelectReports;

  const ReportsComparativeCard({
    super.key,
    this.selectedReports = const [],
    this.onSelectReports,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final hasData = selectedReports.isNotEmpty;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: context.cShadow,
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFF2D3748),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.bar_chart_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'COMPARATIVE\nANALYTICS',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: cs.onSurface,
                        height: 1.2,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Trend mapping between two labs',
                      style: TextStyle(
                        fontSize: 12,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: hasData ? null : onSelectReports,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(
                color: cs.surfaceContainerHighest.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: cs.outline.withValues(alpha: 0.2),
                ),
              ),
              child: hasData
                  ? _AnalyticsChart(reports: selectedReports, cs: cs)
                  : Column(
                      children: [
                        Icon(
                          Icons.show_chart_rounded,
                          size: 44,
                          color: cs.onSurfaceVariant.withValues(alpha: 0.3),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Select report(s) from history\nto visualize analytics',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: cs.onSurfaceVariant.withValues(alpha: 0.7),
                            height: 1.5,
                          ),
                        ),
                        if (onSelectReports != null) ...[
                          const SizedBox(height: 14),
                          OutlinedButton(
                            onPressed: onSelectReports,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: cs.primary,
                              side: BorderSide(
                                  color: cs.primary.withValues(alpha: 0.5)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              'Select Reports',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnalyticsChart extends StatelessWidget {
  final List<String> reports;
  final ColorScheme cs;

  const _AnalyticsChart({required this.reports, required this.cs});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text(
            'Lab comparison chart coming soon',
            style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
