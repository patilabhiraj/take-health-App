import 'package:flutter/material.dart';
import 'package:take_health/core/theme/app_colors.dart';

class ReportArchiveItem {
  final String name;
  final String date;
  final String type;
  final String size;

  const ReportArchiveItem({
    required this.name,
    required this.date,
    required this.type,
    required this.size,
  });
}

class ReportsArchivesCard extends StatelessWidget {
  final List<ReportArchiveItem> archives;
  final VoidCallback? onViewAll;

  const ReportsArchivesCard({
    super.key,
    this.archives = const [],
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

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
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFF2D3748),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.history_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Text(
                'RECENT ARCHIVES',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: cs.onSurface,
                  letterSpacing: 0.4,
                ),
              ),
              const Spacer(),
              if (archives.isNotEmpty && onViewAll != null)
                GestureDetector(
                  onTap: onViewAll,
                  child: Text(
                    'View all',
                    style: TextStyle(
                      fontSize: 12,
                      color: cs.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          if (archives.isEmpty)
            _EmptyState(cs: cs)
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: archives.length,
              separatorBuilder: (_, _) => Divider(
                height: 1,
                color: cs.outline.withValues(alpha: 0.2),
              ),
              itemBuilder: (context, i) =>
                  _ArchiveRow(item: archives[i], cs: cs),
            ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final ColorScheme cs;

  const _EmptyState({required this.cs});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: Text(
          'No records found',
          style: TextStyle(
            fontSize: 14,
            color: cs.onSurfaceVariant.withValues(alpha: 0.6),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class _ArchiveRow extends StatelessWidget {
  final ReportArchiveItem item;
  final ColorScheme cs;

  const _ArchiveRow({required this.item, required this.cs});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: cs.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              item.type.toLowerCase() == 'pdf'
                  ? Icons.picture_as_pdf_outlined
                  : Icons.image_outlined,
              color: cs.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: cs.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Text(
                  '${item.date} · ${item.size}',
                  style: TextStyle(
                    fontSize: 11,
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.arrow_forward_ios_rounded,
              size: 14, color: cs.onSurfaceVariant),
        ],
      ),
    );
  }
}
