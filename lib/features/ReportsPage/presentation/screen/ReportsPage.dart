import 'package:flutter/material.dart';
import '../widgets/reports_archives_card.dart';
import '../widgets/reports_comparative_card.dart';
import '../widgets/reports_header_section.dart';
import '../widgets/reports_upload_card.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  final _scrollController = ScrollController();
  bool _showScrollTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final shouldShow = _scrollController.offset > 180;
      if (shouldShow != _showScrollTop) {
        setState(() => _showScrollTop = shouldShow);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  void _onSelectFile(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('File picker coming soon'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ReportsHeaderSection(),
              const SizedBox(height: 20),
              ReportsUploadCard(
                onSelectFile: () => _onSelectFile(context),
              ),
              const SizedBox(height: 16),
              const ReportsComparativeCard(),
              const SizedBox(height: 16),
              const ReportsArchivesCard(),
              const SizedBox(height: 16),
            ],
          ),
        ),

        // ── Floating action buttons ─────────────────────────────────────────
        Positioned(
          right: 16,
          bottom: 90,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSlide(
                offset: _showScrollTop ? Offset.zero : const Offset(0, 1),
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                child: AnimatedOpacity(
                  opacity: _showScrollTop ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 250),
                  child: _FloatingButton(
                    icon: Icons.keyboard_arrow_up_rounded,
                    color: const Color(0xFF2D3748),
                    onTap: _scrollToTop,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _FloatingButton(
                icon: Icons.chat_bubble_outline_rounded,
                color: cs.primary,
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FloatingButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _FloatingButton({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.35),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }
}
