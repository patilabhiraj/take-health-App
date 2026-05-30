import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_health/features/ai_chat/domain/entities/chat_message.dart';
import 'package:take_health/features/ai_chat/domain/usecases/clear_chat_history_usecase.dart';
import 'package:take_health/features/ai_chat/domain/usecases/get_chat_history_usecase.dart';
import 'package:take_health/features/ai_chat/domain/usecases/save_chat_history_usecase.dart';
import 'package:take_health/features/ai_chat/domain/usecases/send_chat_message_usecase.dart';
import 'ai_chat_event.dart';
import 'ai_chat_state.dart';

class AiChatBloc extends Bloc<AiChatEvent, AiChatState> {
  final SendChatMessageUseCase _sendMessage;
  final GetChatHistoryUseCase _getHistory;
  final SaveChatHistoryUseCase _saveHistory;
  final ClearChatHistoryUseCase _clearHistory;

  AiChatBloc({
    required SendChatMessageUseCase sendMessage,
    required GetChatHistoryUseCase getHistory,
    required SaveChatHistoryUseCase saveHistory,
    required ClearChatHistoryUseCase clearHistory,
  })  : _sendMessage = sendMessage,
        _getHistory = getHistory,
        _saveHistory = saveHistory,
        _clearHistory = clearHistory,
        super(const AiChatState()) {
    on<AiChatLoadHistory>(_onLoadHistory);
    on<AiChatSendMessage>(_onSendMessage);
    on<AiChatClearHistory>(_onClearHistory);
  }

  Future<void> _onLoadHistory(
      AiChatLoadHistory event, Emitter<AiChatState> emit) async {
    emit(state.copyWith(status: AiChatStatus.loading));
    try {
      final messages = await _getHistory();
      emit(state.copyWith(
          messages: messages, status: AiChatStatus.loaded));
    } catch (_) {
      // Start fresh if history fails
      emit(state.copyWith(messages: [], status: AiChatStatus.loaded));
    }
  }

  Future<void> _onSendMessage(
      AiChatSendMessage event, Emitter<AiChatState> emit) async {
    final userMsg = ChatMessage(
      id: '${DateTime.now().microsecondsSinceEpoch}',
      role: 'user',
      content: event.message.trim(),
      timestamp: DateTime.now(),
    );

    final updatedMessages = [...state.messages, userMsg];

    // Show user message + typing indicator
    emit(state.copyWith(
        messages: updatedMessages,
        isTyping: true,
        status: AiChatStatus.loaded));

    try {
      // Only send last 20 messages as context to keep payload small
      final history = updatedMessages.length > 20
          ? updatedMessages.sublist(updatedMessages.length - 20)
          : updatedMessages;

      final reply = await _sendMessage(
        query: event.message.trim(),
        conversationHistory: history,
      );

      final aiMsg = ChatMessage(
        id: '${DateTime.now().microsecondsSinceEpoch}',
        role: 'assistant',
        content: reply,
        timestamp: DateTime.now(),
      );

      final finalMessages = [...updatedMessages, aiMsg];
      emit(state.copyWith(
          messages: finalMessages,
          isTyping: false,
          status: AiChatStatus.loaded));

      // Persist to backend (fire-and-forget)
      _saveHistory(finalMessages).ignore();
    } catch (e) {
      final errMsg = ChatMessage(
        id: '${DateTime.now().microsecondsSinceEpoch}',
        role: 'assistant',
        content:
            "Sorry, I couldn't process that. Please check your connection and try again.",
        timestamp: DateTime.now(),
        isError: true,
      );
      emit(state.copyWith(
          messages: [...updatedMessages, errMsg],
          isTyping: false,
          status: AiChatStatus.error,
          errorMessage: e.toString()));
    }
  }

  Future<void> _onClearHistory(
      AiChatClearHistory event, Emitter<AiChatState> emit) async {
    try {
      await _clearHistory();
      emit(state.copyWith(messages: [], status: AiChatStatus.loaded));
    } catch (_) {
      // Even if backend fails, clear locally
      emit(state.copyWith(messages: []));
    }
  }
}
