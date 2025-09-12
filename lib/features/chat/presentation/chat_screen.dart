import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/chat_providers.dart';
import '../models/chat_models.dart';
import '../../../core/llm/llm_router.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }


  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    ref.read(chatLLMProvider.notifier).sendMessage(text);
    _messageController.clear();
    _scrollToBottom();
  }


  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              child: Icon(
                Icons.smart_toy,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI 건강 상담사',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildStatusText(),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              _showChatOptions();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Quick Actions
          _buildQuickActions(),
          
          // Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: ref.watch(chatLLMProvider).messages.length + (ref.watch(chatLLMProvider).isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                final chatState = ref.watch(chatLLMProvider);
                if (index == chatState.messages.length && chatState.isLoading) {
                  return _buildTypingIndicator();
                }
                return _buildMessageBubble(chatState.messages[index]);
              },
            ),
          ),
          
          // Error display
          if (ref.watch(chatLLMProvider).error != null)
            _buildErrorBar(),
          
          // Input Area
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildQuickActionChip('식단 상담', Icons.restaurant),
          _buildQuickActionChip('운동 추천', Icons.fitness_center),
          _buildQuickActionChip('수면 분석', Icons.bedtime),
          _buildQuickActionChip('스트레스 관리', Icons.psychology),
          _buildQuickActionChip('건강 체크', Icons.health_and_safety),
        ],
      ),
    );
  }

  Widget _buildQuickActionChip(String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ActionChip(
        avatar: Icon(icon, size: 16),
        label: Text(label),
        onPressed: () {
          final quickActions = ref.read(quickActionProvider);
          final message = quickActions[label] ?? '$label에 대해 알려주세요';
          ref.read(chatLLMProvider.notifier).sendMessage(message);
          _scrollToBottom();
        },
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: message.isUser 
            ? MainAxisAlignment.end 
            : MainAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              child: Icon(
                Icons.smart_toy,
                size: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: message.isUser
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(20).copyWith(
                  bottomLeft: message.isUser 
                      ? const Radius.circular(20) 
                      : const Radius.circular(4),
                  bottomRight: message.isUser 
                      ? const Radius.circular(4) 
                      : const Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: message.isUser 
                          ? Colors.white 
                          : message.isError
                            ? Colors.red.shade700
                            : Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        _formatTime(message.timestamp),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: message.isUser 
                              ? Colors.white.withOpacity(0.7)
                              : Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.7),
                        ),
                      ),
                      if (!message.isUser && message.modelDisplayName.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: message.isUser 
                                ? Colors.white.withOpacity(0.2)
                                : message.modelColor.withOpacity(0.1),
                            border: Border.all(
                              color: message.isUser 
                                  ? Colors.white.withOpacity(0.3)
                                  : message.modelColor.withOpacity(0.5),
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: message.isUser 
                                      ? Colors.white.withOpacity(0.8)
                                      : message.modelColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                message.modelDisplayName,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: message.isUser 
                                      ? Colors.white.withOpacity(0.8)
                                      : message.modelColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              child: Icon(
                Icons.person,
                size: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            child: Icon(
              Icons.smart_toy,
              size: 16,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(20).copyWith(
                bottomLeft: const Radius.circular(4),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTypingDot(0),
                const SizedBox(width: 4),
                _buildTypingDot(1),
                const SizedBox(width: 4),
                _buildTypingDot(2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingDot(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 600 + (index * 200)),
      curve: Curves.easeInOut,
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: '건강에 대해 궁금한 점을 물어보세요...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              maxLines: null,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton.small(
            onPressed: _sendMessage,
            child: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }

  Widget _buildStatusText() {
    final chatState = ref.watch(chatLLMProvider);
    final chatNotifier = ref.read(chatLLMProvider.notifier);
    final status = chatNotifier.getLLMStatus();
    
    String statusText = '온라인';
    Color statusColor = Colors.green;
    
    if (chatState.isLoading) {
      statusText = '응답 중...';
      statusColor = Colors.blue;
    } else if (!status['isOnline']) {
      statusText = '오프라인 모드';
      statusColor = Colors.orange;
    } else {
      // Show preferred model in status
      if (status['gemmaAvailable']) {
        statusText = 'Gemma3 사용 가능';
        statusColor = const Color(0xFF4CAF50);
      } else if (status['exaoneAvailable']) {
        statusText = 'EXAONE 사용 가능';
        statusColor = const Color(0xFF2196F3);
      } else {
        statusText = 'GPT-4o 모드';
        statusColor = const Color(0xFFFF9800);
      }
    }

    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: statusColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          statusText,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: statusColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorBar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        border: Border.all(color: Colors.red.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade600, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '연결에 문제가 발생했습니다. 다시 시도해 주세요.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.red.shade700,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              ref.read(chatLLMProvider.notifier).clearError();
            },
            child: Text(
              '닫기',
              style: TextStyle(color: Colors.red.shade600),
            ),
          ),
        ],
      ),
    );
  }

  void _showChatOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '채팅 옵션',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.delete_outline),
              title: const Text('대화 내용 삭제'),
              onTap: () {
                Navigator.pop(context);
                ref.read(chatLLMProvider.notifier).clearMessages();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('대화 내용이 삭제되었습니다')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('AI 설정'),
              onTap: () {
                Navigator.pop(context);
                _showLLMSettings();
              },
            ),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text('도움말'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('도움말 기능 준비 중입니다')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLLMSettings() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'AI 모드 설정',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            
            // LLM Mode Selection
            Consumer(
              builder: (context, ref, child) {
                final chatNotifier = ref.read(chatLLMProvider.notifier);
                final status = chatNotifier.getLLMStatus();
                final currentMode = status['mode'] as LLMMode;
                
                return Column(
                  children: [
                    RadioListTile<LLMMode>(
                      title: const Text('하이브리드 모드'),
                      subtitle: const Text('상황에 따라 최적의 모델 자동 선택'),
                      value: LLMMode.hybrid,
                      groupValue: currentMode,
                      onChanged: (value) {
                        if (value != null) {
                          ref.read(chatLLMProvider.notifier).setLLMMode(value);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('하이브리드 모드로 설정되었습니다')),
                          );
                        }
                      },
                    ),
                    RadioListTile<LLMMode>(
                      title: const Text('온라인 모드'),
                      subtitle: const Text('클라우드 AI (GPT-4o) 사용'),
                      value: LLMMode.online,
                      groupValue: currentMode,
                      onChanged: (value) {
                        if (value != null) {
                          ref.read(chatLLMProvider.notifier).setLLMMode(value);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('온라인 모드로 설정되었습니다')),
                          );
                        }
                      },
                    ),
                    RadioListTile<LLMMode>(
                      title: const Text('오프라인 모드'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('로컬 AI 사용'),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                status['gemmaAvailable'] ? Icons.check_circle : Icons.cancel,
                                size: 16,
                                color: status['gemmaAvailable'] ? const Color(0xFF4CAF50) : Colors.red,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Gemma3 ${status['gemmaAvailable'] ? '사용 가능' : '다운로드 필요'}',
                                style: TextStyle(
                                  color: status['gemmaAvailable'] ? const Color(0xFF4CAF50) : Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Icon(
                                status['exaoneAvailable'] ? Icons.check_circle : Icons.cancel,
                                size: 16,
                                color: status['exaoneAvailable'] ? const Color(0xFF2196F3) : Colors.red,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'EXAONE ${status['exaoneAvailable'] ? '사용 가능' : '다운로드 필요'}',
                                style: TextStyle(
                                  color: status['exaoneAvailable'] ? const Color(0xFF2196F3) : Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      value: LLMMode.offline,
                      groupValue: currentMode,
                      onChanged: (value) {
                        if (value != null) {
                          if (!status['gemmaAvailable'] && !status['exaoneAvailable']) {
                            _showModelDownloadDialog();
                            return;
                          }
                          ref.read(chatLLMProvider.notifier).setLLMMode(value);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('오프라인 모드로 설정되었습니다')),
                          );
                        }
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showModelDownloadDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('오프라인 모델 다운로드'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('오프라인 모드를 사용하려면 로컬 AI 모델을 다운로드해야 합니다.'),
            const SizedBox(height: 16),
            const Text(
              '권장 모델: Gemma3 (한국어 및 건강 상담에 최적화)',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            const Text(
              '터미널에서 다음 명령어를 실행하세요:',
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Text(
                'dart run scripts/model_downloader_cli.dart gemma',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('모델 다운로드 후 다시 시도해주세요.'),
                  duration: Duration(seconds: 3),
                ),
              );
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
}

