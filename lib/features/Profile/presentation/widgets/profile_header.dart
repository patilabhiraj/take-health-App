import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String? profilePicture;
  final String? avatarLetter;
  final String? age;
  final String? gender;
  final String? height;
  final VoidCallback? onCameraTab;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    this.profilePicture,
    this.avatarLetter,
    this.age,
    this.gender,
    this.height,
    this.onCameraTab,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final letter =
        avatarLetter ?? (name.isNotEmpty ? name[0].toUpperCase() : 'U');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _Avatar(
          letter: letter,
          imageUrl: profilePicture,
          cs: cs,
          scaffoldBg: Theme.of(context).scaffoldBackgroundColor,
          onCameraTap: onCameraTab,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name.isNotEmpty ? name : '—',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: cs.onSurface,
                ),
              ),
              const SizedBox(height: 5),
              _StatsRow(
                age: age ?? 'Age not set',
                gender: gender ?? 'Other',
                height: height ?? 'Height not set',
                cs: cs,
              ),
              const SizedBox(height: 5),
              Row(children: [
                Icon(Icons.mail_outline_rounded,
                    size: 14, color: cs.onSurfaceVariant),
                const SizedBox(width: 5),
                Flexible(
                  child: Text(
                    email.isNotEmpty ? email : '—',
                    style: TextStyle(
                        fontSize: 12, color: cs.onSurfaceVariant),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ]),
            ],
          ),
        ),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  final String letter;
  final String? imageUrl;
  final ColorScheme cs;
  final Color scaffoldBg;
  final VoidCallback? onCameraTap;

  const _Avatar({
    required this.letter,
    required this.cs,
    required this.scaffoldBg,
    this.imageUrl,
    this.onCameraTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl != null && imageUrl!.isNotEmpty;

    return Stack(
      children: [
        CircleAvatar(
          radius: 38,
          backgroundColor: cs.surfaceContainerHighest,
          backgroundImage:
              hasImage ? NetworkImage(imageUrl!) : null,
          onBackgroundImageError: hasImage
              ? (error, _) {}
              : null,
          child: hasImage
              ? null
              : Text(
                  letter,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: cs.onSurfaceVariant,
                  ),
                ),
        ),
        Positioned(
          bottom: 2,
          right: 2,
          child: GestureDetector(
            onTap: onCameraTap,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFF2D3748),
                shape: BoxShape.circle,
                border: Border.all(color: scaffoldBg, width: 2),
              ),
              child: const Icon(Icons.camera_alt_outlined,
                  size: 13, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  final String age;
  final String gender;
  final String height;
  final ColorScheme cs;

  const _StatsRow({
    required this.age,
    required this.gender,
    required this.height,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(fontSize: 12, color: cs.onSurfaceVariant);
    final dot = Text(' · ', style: style);
    return Wrap(
      children: [
        Text(age, style: style),
        dot,
        Text(gender, style: style),
        dot,
        Text(height, style: style),
      ],
    );
  }
}
