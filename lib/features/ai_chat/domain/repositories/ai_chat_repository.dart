import '../entities/chat_message.dart';

abstract class AiChatRepository {
  Future<String> sendMessage({
    required String query,
    required List<ChatMessage> conversationHistory,
  });

  Future<List<ChatMessage>> getChatHistory();

  Future<void> saveChatHistory(List<ChatMessage> messages);

  Future<void> clearChatHistory();
}
