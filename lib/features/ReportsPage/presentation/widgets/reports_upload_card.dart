import 'package:flutter/material.dart';
import 'package:take_health/core/theme/app_colors.dart';

class ReportsUploadCard extends StatefulWidget {
  final VoidCallback? onSelectFile;

  const ReportsUploadCard({super.key, this.onSelectFile});

  @override
  State<ReportsUploadCard> createState() => _ReportsUploadCardState();
}

class _ReportsUploadCardState extends State<ReportsUploadCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;
  late final Animation<double> _scale;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
    _scale = Tween<double>(begin: 1.0, end: 1.06).animate(
      CurvedAnimation(parent: _pulse, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
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
        children: [
          GestureDetector(
            onTap: widget.onSelectFile,
            onPanStart: (_) => setState(() => _isDragging = true),
            onPanEnd: (_) => setState(() => _isDragging = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28),
              decoration: BoxDecoration(
                color: _isDragging
                    ? cs.primary.withValues(alpha: 0.08)
                    : cs.surfaceContainerHighest.withValues(alpha: 0.45),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: _isDragging
                      ? cs.primary.withValues(alpha: 0.5)
                      : cs.outline.withValues(alpha: 0.25),
                  width: _isDragging ? 1.5 : 1,
                ),
              ),
              child: Column(
                children: [
                  ScaleTransition(
                    scale: _scale,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: cs.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.upload_file_outlined,
                        color: cs.primary,
                        size: 38,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'UPLOAD LAB REPORT',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: cs.onSurface,
                      letterSpacing: 0.4,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Drag & drop or tap to select\nPDF or image',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: cs.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: widget.onSelectFile,
              style: ElevatedButton.styleFrom(
                backgroundColor: cs.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'SELECT FILE',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
