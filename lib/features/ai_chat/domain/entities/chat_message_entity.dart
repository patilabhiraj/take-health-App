import 'package:equatable/equatable.dart';

class ChatMessageEntity extends Equatable {
  final bool isAi;
  final String text;
  final bool showCopy;
  final List<String>? bullets;

  const ChatMessageEntity({
    required this.isAi,
    required this.text,
    this.showCopy = false,
    this.bullets,
  });

  @override
  List<Object?> get props => [isAi, text, showCopy, bullets];
}
