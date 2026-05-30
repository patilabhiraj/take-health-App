import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_health/app/injection.dart';
import 'package:take_health/features/ai_chat/domain/usecases/clear_chat_history_usecase.dart';
import 'package:take_health/features/ai_chat/domain/usecases/get_chat_history_usecase.dart';
import 'package:take_health/features/ai_chat/domain/usecases/save_chat_history_usecase.dart';
import 'package:take_health/features/ai_chat/domain/usecases/send_chat_message_usecase.dart';
import 'package:take_health/features/ai_chat/presentation/bloc/ai_chat_bloc.dart';
import 'package:take_health/features/ai_chat/presentation/bloc/ai_chat_event.dart';
import 'package:take_health/features/ai_chat/presentation/bloc/ai_chat_state.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/chat_typing_indicator.dart';

class AiChatPage extends StatelessWidget {
  const AiChatPage({super.key});

  static Route<void> route() => MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => AiChatBloc(
            sendMessage: sl<SendChatMessageUseCase>(),
            getHistory: sl<GetChatHistoryUseCase>(),
            saveHistory: sl<SaveChatHistoryUseCase>(),
            clearHistory: sl<ClearChatHistoryUseCase>(),
          )..add(AiChatLoadHistory()),
          child: const AiChatPage(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return const _AiChatView();
  }
}

class _AiChatView extends StatefulWidget {
  const _AiChatView();

  @override
  State<_AiChatView> createState() => _AiChatViewState();
}

class _AiChatViewState extends State<_AiChatView> {
  final _listCtrl = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_listCtrl.hasClients) {
        _listCtrl.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _showClearDialog(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (dCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Clear History',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content:
            const Text('All chat history will be permanently deleted.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dCtx),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(dCtx);
              ctx.read<AiChatBloc>().add(AiChatClearHistory());
            },
            child: Text('Clear',
                style: TextStyle(
                    color: Theme.of(ctx).colorScheme.error,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _listCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: cs.surfaceContainerHighest.withValues(alpha: 0.55),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.arrow_back_ios_new_rounded,
                  size: 17, color: cs.onSurface),
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('AI Health Coach',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: cs.onSurface)),
            Text('Powered by Claude AI',
                style: TextStyle(
                    fontSize: 11, color: cs.onSurfaceVariant)),
          ],
        ),
        actions: [
          BlocBuilder<AiChatBloc, AiChatState>(
            builder: (ctx, state) => IconButton(
              icon: Icon(Icons.delete_outline_rounded,
                  color: state.messages.isEmpty
                      ? cs.onSurfaceVariant
                      : cs.error),
              onPressed: state.messages.isEmpty
                  ? null
                  : () => _showClearDialog(ctx),
              tooltip: 'Clear history',
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<AiChatBloc, AiChatState>(
              listener: (_, state) {
                if (state.messages.isNotEmpty) _scrollToBottom();
              },
              builder: (ctx, state) {
                if (state.status == AiChatStatus.initial ||
                    (state.status == AiChatStatus.loading &&
                        state.messages.isEmpty)) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.messages.isEmpty && !state.isTyping) {
                  return _EmptyState(cs: cs);
                }

                return ListView.builder(
                  controller: _listCtrl,
                  reverse: true,
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  itemCount: state.messages.length + (state.isTyping ? 1 : 0),
                  itemBuilder: (_, i) {
                    if (state.isTyping && i == 0) {
                      return const ChatTypingIndicator();
                    }
                    final idx = state.messages.length -
                        1 -
                        (state.isTyping ? i - 1 : i);
                    return ChatBubble(message: state.messages[idx]);
                  },
                );
              },
            ),
          ),
          BlocBuilder<AiChatBloc, AiChatState>(
            builder: (ctx, state) => ChatInputBar(
              enabled: !state.isTyping,
              onSend: (msg) =>
                  ctx.read<AiChatBloc>().add(AiChatSendMessage(msg)),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final ColorScheme cs;
  const _EmptyState({required this.cs});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cs.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child:
                  Icon(Icons.health_and_safety_outlined, size: 48, color: cs.primary),
            ),
            const SizedBox(height: 20),
            Text('AI Health Coach',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: cs.onSurface)),
            const SizedBox(height: 8),
            Text(
              'Ask me anything about your health — nutrition, reports, fitness goals, or your diet plan.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14, color: cs.onSurfaceVariant, height: 1.5),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                '💊 Analyse my report',
                '🥗 Best foods for me',
                '🏃 My fitness goal',
              ]
                  .map((hint) => GestureDetector(
                        onTap: () => context
                            .read<AiChatBloc>()
                            .add(AiChatSendMessage(hint)),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: cs.primary.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: cs.primary.withValues(alpha: 0.25)),
                          ),
                          child: Text(hint,
                              style: TextStyle(
                                  fontSize: 13, color: cs.primary)),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
