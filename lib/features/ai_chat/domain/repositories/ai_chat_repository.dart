
import 'package:take_health/features/ai_chat/domain/entities/chat_session_entity.dart';

abstract class AiChatRepository {
  /// Load all chat sessions from local storage
  Future<List<ChatSessionEntity>> loadSessions();

  /// Save all chat sessions to local storage
  Future<void> saveSessions(List<ChatSessionEntity> sessions);

  /// Clear all chat sessions
  Future<void> clearSessions();

  /// Generate AI response based on user input
  Future<String> generateResponse(String userInput);
}
