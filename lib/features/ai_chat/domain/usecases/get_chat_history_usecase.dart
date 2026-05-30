import '../entities/chat_message.dart';
import '../repositories/ai_chat_repository.dart';

class GetChatHistoryUseCase {
  final AiChatRepository _repository;
  GetChatHistoryUseCase(this._repository);

  Future<List<ChatMessage>> call() => _repository.getChatHistory();
}
