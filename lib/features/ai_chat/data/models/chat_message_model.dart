import '../../domain/entities/chat_message.dart';

class ChatMessageModel extends ChatMessage {
  const ChatMessageModel({
    required super.id,
    required super.role,
    required super.content,
    required super.timestamp,
    super.isError,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: '${DateTime.now().microsecondsSinceEpoch}',
      role: json['role'] as String? ?? 'assistant',
      content: json['content'] as String? ?? '',
      timestamp: DateTime.now(),
    );
  }

  factory ChatMessageModel.fromEntity(ChatMessage msg) {
    return ChatMessageModel(
      id: msg.id,
      role: msg.role,
      content: msg.content,
      timestamp: msg.timestamp,
      isError: msg.isError,
    );
  }

  Map<String, dynamic> toJson() => {
        'role': role,
        'content': content,
      };
}
