import 'package:flutter/material.dart';

class ProfileSectionLabel extends StatelessWidget {
  final String label;

  const ProfileSectionLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Text(
      label,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w800,
        color: cs.primary,
        letterSpacing: 0.5,
      ),
    );
  }
}
