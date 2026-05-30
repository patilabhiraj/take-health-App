import 'package:dio/dio.dart';
import 'package:take_health/core/constants/api_constants.dart';
import 'package:take_health/core/network/api_client.dart';
import '../models/chat_message_model.dart';

abstract class AiChatRemoteDataSource {
  Future<String> sendMessage({
    required String query,
    required List<ChatMessageModel> conversationHistory,
  });
  Future<List<ChatMessageModel>> getChatHistory();
  Future<void> saveChatHistory(List<ChatMessageModel> messages);
  Future<void> clearChatHistory();
}

class AiChatRemoteDataSourceImpl implements AiChatRemoteDataSource {
  final ApiClient _apiClient;

  AiChatRemoteDataSourceImpl(this._apiClient);

  @override
  Future<String> sendMessage({
    required String query,
    required List<ChatMessageModel> conversationHistory,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        ApiConstants.chat,
        data: {
          'query': query,
          'conversationHistory':
              conversationHistory.map((m) => m.toJson()).toList(),
          'userReports': [],
        },
      );
      final data = response.data as Map<String, dynamic>;
      final reply = data['response'] ??
          data['message'] ??
          data['reply'] ??
          data['answer'] ??
          data['content'] ??
          '';
      return reply.toString();
    } on DioException catch (e) {
      throw Exception(
          e.response?.data?['message'] ?? 'Failed to send message');
    }
  }

  @override
  Future<List<ChatMessageModel>> getChatHistory() async {
    try {
      final response = await _apiClient.dio.get(ApiConstants.chatHistory);
      final data = response.data as Map<String, dynamic>;
      final messages = data['messages'] as List<dynamic>? ?? [];
      return messages
          .map((m) => ChatMessageModel.fromJson(m as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return [];
      throw Exception('Failed to load chat history');
    }
  }

  @override
  Future<void> saveChatHistory(List<ChatMessageModel> messages) async {
    try {
      await _apiClient.dio.post(
        ApiConstants.chatHistory,
        data: {'messages': messages.map((m) => m.toJson()).toList()},
      );
    } on DioException {
      // Non-critical — swallow silently
    }
  }

  @override
  Future<void> clearChatHistory() async {
    try {
      await _apiClient.dio.delete(ApiConstants.chatHistory);
    } on DioException catch (e) {
      throw Exception(
          e.response?.data?['message'] ?? 'Failed to clear history');
    }
  }
}
