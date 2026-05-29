import 'package:flutter/material.dart';

class ProfileDropdownField extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const ProfileDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: cs.outline.withValues(alpha: 0.35)),
    );

    final safeValue = items.contains(value) ? value : items.first;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: cs.onSurfaceVariant,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          initialValue: safeValue,
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item,
                        style: TextStyle(fontSize: 14, color: cs.onSurface)),
                  ))
              .toList(),
          onChanged: onChanged,
          icon: Icon(Icons.keyboard_arrow_down_rounded,
              color: cs.onSurfaceVariant),
          dropdownColor: cs.surface,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            border: baseBorder,
            enabledBorder: baseBorder,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: cs.primary),
            ),
            filled: true,
            fillColor: cs.surface,
          ),
        ),
      ],
    );
  }
}
