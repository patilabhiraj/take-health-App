import '../../domain/entities/chat_message.dart';
import '../../domain/repositories/ai_chat_repository.dart';
import '../datasources/ai_chat_remote_data_source.dart';
import '../models/chat_message_model.dart';

class AiChatRepositoryImpl implements AiChatRepository {
  final AiChatRemoteDataSource _remote;

  AiChatRepositoryImpl(this._remote);

  @override
  Future<String> sendMessage({
    required String query,
    required List<ChatMessage> conversationHistory,
  }) {
    final models =
        conversationHistory.map(ChatMessageModel.fromEntity).toList();
    return _remote.sendMessage(
        query: query, conversationHistory: models);
  }

  @override
  Future<List<ChatMessage>> getChatHistory() => _remote.getChatHistory();

  @override
  Future<void> saveChatHistory(List<ChatMessage> messages) =>
      _remote.saveChatHistory(
          messages.map(ChatMessageModel.fromEntity).toList());

  @override
  Future<void> clearChatHistory() => _remote.clearChatHistory();
}
