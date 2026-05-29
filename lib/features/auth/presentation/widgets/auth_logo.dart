import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Take Health logo widget - white version for dark backgrounds
class AuthLogo extends StatelessWidget {
  const AuthLogo({super.key, this.dark = false});

  /// If true, uses dark green colors (for light backgrounds)
  final bool dark;

  @override
  Widget build(BuildContext context) {
    final color = dark ? AppColors.primary : Colors.white;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Triangle logo icon
        CustomPaint(
          size: const Size(32, 32),
          painter: _TakeHealthLogoPainter(color: color),
        ),
        const SizedBox(width: 10),
        Text(
          'TAKE HEALTH',
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}

class _TakeHealthLogoPainter extends CustomPainter {
  final Color color;
  _TakeHealthLogoPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    // Outer triangle
    path.moveTo(size.width * 0.5, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    // Inner lines (health cross style)
    final innerPath = Path();
    innerPath.moveTo(size.width * 0.5, size.height * 0.2);
    innerPath.lineTo(size.width * 0.5, size.height * 0.75);
    innerPath.moveTo(size.width * 0.3, size.height * 0.55);
    innerPath.lineTo(size.width * 0.7, size.height * 0.55);

    canvas.drawPath(path, paint);
    canvas.drawPath(innerPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
