import '../entities/chat_message.dart';
import '../repositories/ai_chat_repository.dart';

class SendChatMessageUseCase {
  final AiChatRepository _repository;
  SendChatMessageUseCase(this._repository);

  Future<String> call({
    required String query,
    required List<ChatMessage> conversationHistory,
  }) =>
      _repository.sendMessage(
          query: query, conversationHistory: conversationHistory);
}
