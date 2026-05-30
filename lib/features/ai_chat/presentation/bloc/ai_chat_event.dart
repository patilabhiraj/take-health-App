abstract class AiChatEvent {}

class AiChatLoadHistory extends AiChatEvent {}

class AiChatSendMessage extends AiChatEvent {
  final String message;
  AiChatSendMessage(this.message);
}

class AiChatClearHistory extends AiChatEvent {}
