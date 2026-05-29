import 'package:flutter/material.dart';
import 'profile_dropdown_field.dart';
import 'profile_form_field.dart';

class ProfileGoalForm extends StatelessWidget {
  final String healthObjective;
  final TextEditingController targetWeightController;
  final String timeframe;
  final ValueChanged<String?> onObjectiveChanged;
  final ValueChanged<String?> onTimeframeChanged;
  final VoidCallback onSync;

  const ProfileGoalForm({
    super.key,
    required this.healthObjective,
    required this.targetWeightController,
    required this.timeframe,
    required this.onObjectiveChanged,
    required this.onTimeframeChanged,
    required this.onSync,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileDropdownField(
          label: 'HEALTH OBJECTIVE',
          value: healthObjective,
          items: const [
            'Maintain weight',
            'Lose weight',
            'Gain muscle',
            'Improve stamina',
            'General wellness',
          ],
          onChanged: onObjectiveChanged,
        ),
        const SizedBox(height: 14),
        Row(children: [
          Expanded(child: _CurrentWeightTile(cs: cs)),
          const SizedBox(width: 10),
          Expanded(
            child: ProfileFormField(
              label: 'TARGET WEIGHT',
              controller: targetWeightController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              hint: 'kg',
            ),
          ),
        ]),
        const SizedBox(height: 14),
        ProfileDropdownField(
          label: 'TARGET TIMEFRAME',
          value: timeframe,
          items: const [
            '4 Weeks (Fast)',
            '8 Weeks (Moderate)',
            '12 Weeks (Sustainable)',
            '24 Weeks (Long-term)',
          ],
          onChanged: onTimeframeChanged,
        ),
        const SizedBox(height: 10),
        _TipBanner(cs: cs),
        const SizedBox(height: 18),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onSync,
            style: ElevatedButton.styleFrom(
              backgroundColor: cs.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              elevation: 0,
            ),
            child: const Text(
              'SYNC FITNESS PLAN',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CurrentWeightTile extends StatelessWidget {
  final ColorScheme cs;

  const _CurrentWeightTile({required this.cs});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.primary.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CURRENT WEIGHT',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: cs.primary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 10),
          Row(children: [
            Text(
              '—',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: cs.onSurface,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              'kg',
              style: TextStyle(fontSize: 13, color: cs.onSurfaceVariant),
            ),
          ]),
        ],
      ),
    );
  }
}

class _TipBanner extends StatelessWidget {
  final ColorScheme cs;

  const _TipBanner({required this.cs});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(children: [
        Icon(Icons.lightbulb_outline_rounded, size: 15, color: cs.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'Tip: 12 weeks is recommended for sustainable fat loss or muscle gain.',
            style: TextStyle(
              fontSize: 11,
              color: cs.onSurfaceVariant,
              height: 1.4,
            ),
          ),
        ),
      ]),
    );
  }
}
