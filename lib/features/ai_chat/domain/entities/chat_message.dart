class ChatMessage {
  final String id;
  final String role; // 'user' | 'assistant'
  final String content;
  final DateTime timestamp;
  final bool isError;

  const ChatMessage({
    required this.id,
    required this.role,
    required this.content,
    required this.timestamp,
    this.isError = false,
  });

  bool get isUser => role == 'user';
  bool get isAssistant => role == 'assistant';
}
