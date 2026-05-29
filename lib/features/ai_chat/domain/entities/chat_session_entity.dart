import 'package:equatable/equatable.dart';
import 'package:take_health/features/Ai_chat/domain/entities/chat_message_entity.dart';

class ChatSessionEntity extends Equatable {
  final String id;
  final String title;
  final List<ChatMessageEntity> messages;

  const ChatSessionEntity({
    required this.id,
    required this.title,
    required this.messages,
  });

  @override
  List<Object?> get props => [id, title, messages];
}
