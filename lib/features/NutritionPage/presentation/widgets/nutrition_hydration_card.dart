import 'package:flutter/material.dart';
import 'package:take_health/core/theme/app_colors.dart';

class NutritionHydrationCard extends StatefulWidget {
  final int glassGoal;
  final int mlPerGlass;

  const NutritionHydrationCard({
    super.key,
    this.glassGoal = 8,
    this.mlPerGlass = 250,
  });

  @override
  State<NutritionHydrationCard> createState() =>
      _NutritionHydrationCardState();
}

class _NutritionHydrationCardState extends State<NutritionHydrationCard> {
  int _glasses = 0;

  int get _totalMl => _glasses * widget.mlPerGlass;
  int get _totalGoalMl => widget.glassGoal * widget.mlPerGlass;
  int get _remainingMl => _totalGoalMl - _totalMl;

  void _increment() {
    if (_glasses < widget.glassGoal) setState(() => _glasses++);
  }

  void _decrement() {
    if (_glasses > 0) setState(() => _glasses--);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final progress = _glasses / widget.glassGoal;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hydration Tracker',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            'GOAL: ${widget.glassGoal} GLASSES',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: cs.onSurfaceVariant,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(widget.glassGoal, (i) {
              final filled = i < _glasses;
              return Icon(
                filled ? Icons.local_drink : Icons.local_drink_outlined,
                color: filled
                    ? cs.primary
                    : cs.onSurfaceVariant.withValues(alpha: 0.28),
                size: 26,
              );
            }),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              _RoundButton(
                icon: Icons.remove,
                onTap: _decrement,
                enabled: _glasses > 0,
                cs: cs,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    '$_glasses',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: cs.onSurface,
                    ),
                  ),
                ),
              ),
              _RoundButton(
                icon: Icons.add,
                onTap: _increment,
                enabled: _glasses < widget.glassGoal,
                cs: cs,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$_totalMl ml',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: cs.primary,
                ),
              ),
              Text(
                '$_remainingMl ml left',
                style: TextStyle(
                  fontSize: 13,
                  color: cs.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: cs.surfaceContainerHighest,
              color: cs.primary,
              minHeight: 7,
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool enabled;
  final ColorScheme cs;

  const _RoundButton({
    required this.icon,
    required this.onTap,
    required this.enabled,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: enabled
              ? cs.primaryContainer
              : cs.surfaceContainerHighest,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: enabled ? cs.primary : cs.onSurfaceVariant,
          size: 22,
        ),
      ),
    );
  }
}
