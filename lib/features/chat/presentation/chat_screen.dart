import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/chat_providers.dart';
import '../providers/model_management_provider.dart';
import '../models/chat_models.dart';
import '../../../core/llm/llm_router.dart';
import '../../../core/llm/model_downloader.dart';

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
      // Show preferred model in status (prioritize new models)
      if (status['exaone4Available']) {
        statusText = 'EXAONE 4.0 사용 가능';
        statusColor = const Color(0xFF00BCD4);
      } else if (status['medGemmaAvailable']) {
        statusText = 'MedGemma 사용 가능';
        statusColor = const Color(0xFFE91E63);
      } else if (status['gemmaAvailable']) {
        statusText = 'Gemma3 사용 가능';
        statusColor = const Color(0xFF4CAF50);
      } else if (status['exaoneAvailable']) {
        statusText = 'EXAONE 3.5 사용 가능';
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
                          Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            children: [
                              _buildModelStatusChip(
                                'EXAONE 4.0',
                                status['exaone4Available'],
                                const Color(0xFF00BCD4),
                              ),
                              _buildModelStatusChip(
                                'MedGemma',
                                status['medGemmaAvailable'],
                                const Color(0xFFE91E63),
                              ),
                              _buildModelStatusChip(
                                'Gemma3',
                                status['gemmaAvailable'],
                                const Color(0xFF4CAF50),
                              ),
                              _buildModelStatusChip(
                                'EXAONE 3.5',
                                status['exaoneAvailable'],
                                const Color(0xFF2196F3),
                              ),
                            ],
                          ),
                        ],
                      ),
                      value: LLMMode.offline,
                      groupValue: currentMode,
                      onChanged: (value) {
                        if (value != null) {
                          if (!status['exaone4Available'] &&
                              !status['medGemmaAvailable'] &&
                              !status['gemmaAvailable'] &&
                              !status['exaoneAvailable']) {
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

  Widget _buildModelStatusChip(String name, bool available, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: available ? color.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: available ? color : Colors.grey,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            available ? Icons.check_circle : Icons.cancel,
            size: 14,
            color: available ? color : Colors.grey,
          ),
          const SizedBox(width: 4),
          Text(
            name,
            style: TextStyle(
              color: available ? color : Colors.grey,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showModelDownloadDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => Consumer(
        builder: (context, ref, child) {
          final managementState = ref.watch(modelManagementProvider);

          return AlertDialog(
            title: const Text('오프라인 모델 다운로드'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('오프라인 모드를 사용하려면 로컬 AI 모델을 다운로드해야 합니다.'),
                  const SizedBox(height: 8),
                  Text(
                    '• Wi-Fi 연결을 권장합니다\n• 다운로드는 백그라운드에서 진행됩니다',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '추천 모델:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildDownloadableModelCard(
                    managementState,
                    ModelType.exaone4_1B,
                    'EXAONE 4.0 1.2B',
                    '한국어 특화, 경량',
                    const Color(0xFF00BCD4),
                    Icons.translate,
                  ),
                  const SizedBox(height: 8),
                  _buildDownloadableModelCard(
                    managementState,
                    ModelType.medGemma4B,
                    'MedGemma 4B',
                    '의료 전문, 멀티모달',
                    const Color(0xFFE91E63),
                    Icons.medical_services,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('닫기'),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDownloadableModelCard(
    ModelManagementState state,
    ModelType modelType,
    String name,
    String description,
    Color color,
    IconData icon,
  ) {
    final modelInfo = state.modelInfos[modelType]!;
    final status = state.modelStatuses[modelType] ?? DownloadStatus.notDownloaded;
    final progress = state.downloadProgresses[modelType];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      '$description • ${modelInfo.displaySize}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Download Progress
          if (status == DownloadStatus.downloading && progress != null) ...[
            LinearProgressIndicator(
              value: progress.percentage / 100,
              backgroundColor: color.withOpacity(0.1),
              color: color,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${progress.percentage.toStringAsFixed(1)}%',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  '${progress.speedDisplay} • ${progress.etaDisplay}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ] else if (status == DownloadStatus.verifying) ...[
            LinearProgressIndicator(
              backgroundColor: color.withOpacity(0.1),
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              '파일 검증 중...',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],

          const SizedBox(height: 8),

          // Action Button
          SizedBox(
            width: double.infinity,
            child: _buildModelActionButton(modelType, status, color),
          ),
        ],
      ),
    );
  }

  Widget _buildModelActionButton(ModelType modelType, DownloadStatus status, Color color) {
    switch (status) {
      case DownloadStatus.notDownloaded:
        return ElevatedButton.icon(
          onPressed: () => _startModelDownload(modelType),
          icon: const Icon(Icons.download, size: 18),
          label: const Text('다운로드'),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
          ),
        );

      case DownloadStatus.downloading:
        return OutlinedButton.icon(
          onPressed: () => _cancelModelDownload(modelType),
          icon: const Icon(Icons.cancel, size: 18),
          label: const Text('취소'),
          style: OutlinedButton.styleFrom(
            foregroundColor: color,
          ),
        );

      case DownloadStatus.downloaded:
        return Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '다운로드 완료',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
            IconButton(
              onPressed: () => _deleteModel(modelType),
              icon: const Icon(Icons.delete_outline, size: 18),
              color: Colors.red,
              tooltip: '삭제',
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        );

      case DownloadStatus.failed:
        return ElevatedButton.icon(
          onPressed: () => _startModelDownload(modelType),
          icon: const Icon(Icons.refresh, size: 18),
          label: const Text('다시 시도'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
          ),
        );

      case DownloadStatus.verifying:
        return const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            SizedBox(width: 8),
            Text('검증 중...', style: TextStyle(fontSize: 13)),
          ],
        );
    }
  }

  void _startModelDownload(ModelType modelType) {
    final modelInfo = ref.read(modelManagementProvider).modelInfos[modelType]!;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${modelInfo.name} 다운로드를 시작합니다...'),
        duration: const Duration(seconds: 2),
      ),
    );

    ref.read(modelManagementProvider.notifier).downloadModel(modelType);
  }

  void _cancelModelDownload(ModelType modelType) {
    ref.read(modelManagementProvider.notifier).cancelDownload(modelType);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('다운로드가 취소되었습니다'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _deleteModel(ModelType modelType) {
    final modelInfo = ref.read(modelManagementProvider).modelInfos[modelType]!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('모델 삭제'),
        content: Text('${modelInfo.name}을(를) 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await ref.read(modelManagementProvider.notifier).deleteModel(modelType);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(success ? '모델이 삭제되었습니다' : '모델 삭제에 실패했습니다'),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }

}

