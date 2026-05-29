import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool readOnly;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? hint;
  final int maxLines;

  const ProfileFormField({
    super.key,
    required this.label,
    required this.controller,
    this.readOnly = false,
    this.keyboardType,
    this.inputFormatters,
    this.hint,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: cs.outline.withValues(alpha: 0.35)),
    );

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
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          maxLines: maxLines,
          style: TextStyle(fontSize: 14, color: cs.onSurface),
          decoration: InputDecoration(
            hintText: hint,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            border: baseBorder,
            enabledBorder: baseBorder,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: cs.primary),
            ),
            filled: true,
            fillColor: readOnly
                ? cs.surfaceContainerHighest.withValues(alpha: 0.3)
                : cs.surface,
          ),
        ),
      ],
    );
  }
}
