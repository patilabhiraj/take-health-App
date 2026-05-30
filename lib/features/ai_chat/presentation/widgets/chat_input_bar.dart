import 'package:flutter/material.dart';

class ChatInputBar extends StatefulWidget {
  final bool enabled;
  final ValueChanged<String> onSend;

  const ChatInputBar({
    super.key,
    required this.onSend,
    this.enabled = true,
  });

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final _ctrl = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _ctrl.addListener(() {
      final has = _ctrl.text.trim().isNotEmpty;
      if (has != _hasText) setState(() => _hasText = has);
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _send() {
    final text = _ctrl.text.trim();
    if (text.isEmpty || !widget.enabled) return;
    widget.onSend(text);
    _ctrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
      decoration: BoxDecoration(
        color: cs.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: cs.surfaceContainerHighest.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: _ctrl,
                  enabled: widget.enabled,
                  maxLines: 4,
                  minLines: 1,
                  textInputAction: TextInputAction.newline,
                  style: TextStyle(fontSize: 15, color: cs.onSurface),
                  decoration: InputDecoration(
                    hintText: 'Ask your health coach…',
                    hintStyle: TextStyle(
                        fontSize: 14, color: cs.onSurfaceVariant),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: _hasText && widget.enabled
                    ? cs.primary
                    : cs.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: _hasText && widget.enabled ? _send : null,
                icon: Icon(
                  Icons.send_rounded,
                  size: 20,
                  color: _hasText && widget.enabled
                      ? cs.onPrimary
                      : cs.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
