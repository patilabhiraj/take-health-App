import 'package:take_health/features/ai_chat/domain/entities/chat_message.dart';

enum AiChatStatus { initial, loading, loaded, error }

class AiChatState {
  final List<ChatMessage> messages;
  final AiChatStatus status;
  final bool isTyping;
  final String? errorMessage;

  const AiChatState({
    this.messages = const [],
    this.status = AiChatStatus.initial,
    this.isTyping = false,
    this.errorMessage,
  });

  AiChatState copyWith({
    List<ChatMessage>? messages,
    AiChatStatus? status,
    bool? isTyping,
    String? errorMessage,
  }) =>
      AiChatState(
        messages: messages ?? this.messages,
        status: status ?? this.status,
        isTyping: isTyping ?? this.isTyping,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
