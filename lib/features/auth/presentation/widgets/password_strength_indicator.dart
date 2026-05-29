import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  const PasswordStrengthIndicator({super.key, required this.password});

  final String password;

  bool get _hasLength => password.length >= 8;
  bool get _hasNumber => password.contains(RegExp(r'[0-9]'));
  bool get _hasSymbol => password.contains(RegExp(r'[^a-zA-Z0-9]'));

  int get _strength =>
      [_hasLength, _hasNumber, _hasSymbol].where((v) => v).length;

  Color get _barColor {
    switch (_strength) {
      case 1:
        return const Color(0xFFDC2626);
      case 2:
        return const Color(0xFFEAB308);
      case 3:
        return const Color(0xFF16A34A);
      default:
        return AppColors.lightMuted;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (password.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: TweenAnimationBuilder<double>(
            tween: Tween(end: _strength / 3),
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOut,
            builder: (context, value, _) => LinearProgressIndicator(
              value: value,
              backgroundColor: AppColors.lightMuted,
              valueColor: AlwaysStoppedAnimation<Color>(_barColor),
              minHeight: 5,
            ),
          ),
        ),
        const SizedBox(height: 14),
        _Requirement(label: '8 characters minimum', met: _hasLength),
        const SizedBox(height: 6),
        _Requirement(label: 'a number', met: _hasNumber),
        const SizedBox(height: 6),
        _Requirement(label: 'one symbol minimum', met: _hasSymbol),
      ],
    );
  }
}

class _Requirement extends StatelessWidget {
  const _Requirement({required this.label, required this.met});

  final String label;
  final bool met;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Icon(
            met
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            key: ValueKey(met),
            size: 16,
            color: met ? const Color(0xFF16A34A) : cs.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: met ? cs.onSurface : cs.onSurfaceVariant,
            fontSize: 13,
            fontWeight: met ? FontWeight.w500 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
