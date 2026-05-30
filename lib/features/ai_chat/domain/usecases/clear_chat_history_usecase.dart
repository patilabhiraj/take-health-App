import '../repositories/ai_chat_repository.dart';

class ClearChatHistoryUseCase {
  final AiChatRepository _repository;
  ClearChatHistoryUseCase(this._repository);

  Future<void> call() => _repository.clearChatHistory();
}
