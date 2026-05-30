import '../entities/chat_message.dart';
import '../repositories/ai_chat_repository.dart';

class SaveChatHistoryUseCase {
  final AiChatRepository _repository;
  SaveChatHistoryUseCase(this._repository);

  Future<void> call(List<ChatMessage> messages) =>
      _repository.saveChatHistory(messages);
}
