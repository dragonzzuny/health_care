import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/challenge_providers.dart';
import '../models/challenge_data.dart';

class ChallengeScreen extends ConsumerStatefulWidget {
  const ChallengeScreen({super.key});

  @override
  ConsumerState<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends ConsumerState<ChallengeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('챌린지'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '일간'),
            Tab(text: '주간'),
            Tab(text: '개인'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDailyChallenges(),
          _buildWeeklyChallenges(),
          _buildPersonalChallenges(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateChallengeDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildDailyChallenges() {
    return Consumer(
      builder: (context, ref, child) {
        final dailyChallengesAsync = ref.watch(dailyChallengesProvider);
        final challengeManager = ref.watch(challengeManagerProvider.notifier);

        return dailyChallengesAsync.when(
          data: (challenges) => RefreshIndicator(
            onRefresh: () async {
              await challengeManager.updateProgress();
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '일간 챌린지',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await challengeManager.updateProgress();
                        },
                        icon: const Icon(Icons.refresh),
                        tooltip: '새로고침',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (challenges.isEmpty)
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 40),
                          Icon(
                            Icons.assignment_outlined,
                            size: 64,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '진행 중인 일간 챌린지가 없습니다',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    )
                  else
                    ...challenges.map((challenge) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildChallengeCardFromModel(challenge, challengeManager),
                    )),
                ],
              ),
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text('챌린지를 불러올 수 없습니다: $error'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => ref.invalidate(dailyChallengesProvider),
                  child: const Text('재시도'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildWeeklyChallenges() {
    return Consumer(
      builder: (context, ref, child) {
        final weeklyChallengesAsync = ref.watch(weeklyChallengesProvider);
        final challengeManager = ref.watch(challengeManagerProvider.notifier);

        return weeklyChallengesAsync.when(
          data: (challenges) => RefreshIndicator(
            onRefresh: () async {
              await challengeManager.updateProgress();
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '주간 챌린지',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await challengeManager.updateProgress();
                        },
                        icon: const Icon(Icons.refresh),
                        tooltip: '새로고침',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (challenges.isEmpty)
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 40),
                          Icon(
                            Icons.calendar_view_week_outlined,
                            size: 64,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '진행 중인 주간 챌린지가 없습니다',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    )
                  else
                    ...challenges.map((challenge) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildChallengeCardFromModel(challenge, challengeManager),
                    )),
                ],
              ),
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text('챌린지를 불러올 수 없습니다: $error'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => ref.invalidate(weeklyChallengesProvider),
                  child: const Text('재시도'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPersonalChallenges() {
    return Consumer(
      builder: (context, ref, child) {
        final personalChallengesAsync = ref.watch(personalChallengesProvider);
        final challengeManager = ref.watch(challengeManagerProvider.notifier);

        return personalChallengesAsync.when(
          data: (challenges) => RefreshIndicator(
            onRefresh: () async {
              await challengeManager.updateProgress();
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '개인 챌린지',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await challengeManager.updateProgress();
                        },
                        icon: const Icon(Icons.refresh),
                        tooltip: '새로고침',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (challenges.isEmpty)
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 40),
                          Icon(
                            Icons.person_outline,
                            size: 64,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '개인 챌린지가 없습니다',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '새로운 챌린지를 만들어보세요!',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ...challenges.map((challenge) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildChallengeCardFromModel(challenge, challengeManager),
                    )),
                ],
              ),
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text('챌린지를 불러올 수 없습니다: $error'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => ref.invalidate(personalChallengesProvider),
                  child: const Text('재시도'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildChallengeCardFromModel(Challenge challenge, ChallengeManagerNotifier challengeManager) {
    final progress = challenge.targetValue > 0
        ? (challenge.currentProgress / challenge.targetValue).clamp(0.0, 1.0)
        : 0.0;

    Color color;
    IconData icon;

    switch (challenge.category) {
      case ChallengeCategory.steps:
        color = challenge.status == ChallengeStatus.completed ? Colors.green : Colors.blue;
        icon = Icons.directions_walk;
        break;
      case ChallengeCategory.sleep:
        color = challenge.status == ChallengeStatus.completed ? Colors.green : Colors.indigo;
        icon = Icons.bedtime;
        break;
      case ChallengeCategory.water:
        color = challenge.status == ChallengeStatus.completed ? Colors.green : Colors.cyan;
        icon = Icons.water_drop;
        break;
      case ChallengeCategory.exercise:
        color = challenge.status == ChallengeStatus.completed ? Colors.green : Colors.orange;
        icon = Icons.fitness_center;
        break;
      case ChallengeCategory.custom:
        color = challenge.status == ChallengeStatus.completed ? Colors.green : Colors.purple;
        icon = Icons.star;
        break;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        challenge.category.emoji,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 4),
                      Icon(icon, color: color, size: 20),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        challenge.title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        challenge.description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                if (challenge.status == ChallengeStatus.completed)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check, color: Colors.green, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '완료',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (challenge.isCustom)
                  PopupMenuButton<String>(
                    onSelected: (value) async {
                      if (value == 'update') {
                        _showUpdateProgressDialog(challenge, challengeManager);
                      } else if (value == 'delete') {
                        _showDeleteConfirmDialog(challenge, challengeManager);
                      }
                    },
                    itemBuilder: (context) => [
                      if (challenge.category == ChallengeCategory.water ||
                          challenge.category == ChallengeCategory.exercise ||
                          challenge.category == ChallengeCategory.custom)
                        const PopupMenuItem(
                          value: 'update',
                          child: Text('진행률 업데이트'),
                        ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('삭제'),
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_formatNumber(challenge.currentProgress)} / ${_formatNumber(challenge.targetValue)} ${challenge.unit}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${(progress * 100).toInt()}%',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                    if (challenge.points > 0)
                      Text(
                        '${challenge.points}점',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: color.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
            if (challenge.status == ChallengeStatus.failed)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Icon(Icons.error, color: Colors.red, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      '챌린지 실패',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }


  void _showUpdateProgressDialog(Challenge challenge, ChallengeManagerNotifier challengeManager) {
    final TextEditingController controller = TextEditingController(
      text: challenge.currentProgress.toString(),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('진행률 업데이트'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${challenge.title}의 현재 진행률을 입력하세요.'),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '진행률',
                suffixText: challenge.unit,
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () async {
              final value = int.tryParse(controller.text);
              if (value != null && value >= 0) {
                await challengeManager.updateManualProgress(challenge.id, value);
                if (mounted) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('진행률이 업데이트되었습니다')),
                  );
                }
              } else {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('올바른 숫자를 입력해주세요')),
                  );
                }
              }
            },
            child: const Text('업데이트'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmDialog(Challenge challenge, ChallengeManagerNotifier challengeManager) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('챌린지 삭제'),
        content: Text('${challenge.title} 챌린지를 정말 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () async {
              await challengeManager.deleteChallenge(challenge.id);
              if (mounted) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('챌린지가 삭제되었습니다')),
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

  void _showCreateChallengeDialog() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _CreateChallengeScreen(),
      ),
    );
  }



  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else {
      return number.toString();
    }
  }
}

class _CreateChallengeScreen extends ConsumerStatefulWidget {
  @override
  _CreateChallengeScreenState createState() => _CreateChallengeScreenState();
}

class _CreateChallengeScreenState extends ConsumerState<_CreateChallengeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _targetValueController = TextEditingController();
  final _unitController = TextEditingController();

  ChallengeCategory _selectedCategory = ChallengeCategory.custom;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 7));
  int _points = 100;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _targetValueController.dispose();
    _unitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('새 챌린지 만들기'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '챌린지 정보',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Title
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: '챌린지 제목',
                  border: OutlineInputBorder(),
                  hintText: '예: 매일 30분 운동하기',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '제목을 입력해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Description
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: '설명',
                  border: OutlineInputBorder(),
                  hintText: '챌린지에 대한 간단한 설명',
                ),
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '설명을 입력해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Category
              DropdownButtonFormField<ChallengeCategory>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: '카테고리',
                  border: OutlineInputBorder(),
                ),
                items: ChallengeCategory.values.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Row(
                      children: [
                        Text(category.emoji),
                        const SizedBox(width: 8),
                        Text(category.label),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedCategory = value;
                      // 카테고리에 따른 기본 단위 설정
                      switch (value) {
                        case ChallengeCategory.steps:
                          _unitController.text = '걸음';
                          break;
                        case ChallengeCategory.sleep:
                          _unitController.text = '시간';
                          break;
                        case ChallengeCategory.water:
                          _unitController.text = '잔';
                          break;
                        case ChallengeCategory.exercise:
                          _unitController.text = '분';
                          break;
                        case ChallengeCategory.custom:
                          _unitController.text = '';
                          break;
                      }
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              // Target and Unit
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _targetValueController,
                      decoration: const InputDecoration(
                        labelText: '목표값',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '목표값을 입력해주세요';
                        }
                        if (int.tryParse(value) == null || int.parse(value) <= 0) {
                          return '올바른 숫자를 입력해주세요';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: _unitController,
                      decoration: const InputDecoration(
                        labelText: '단위',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '단위를 입력해주세요';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              Text(
                '기간 설정',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Start Date
              ListTile(
                title: const Text('시작 날짜'),
                subtitle: Text('${_startDate.year}-${_startDate.month.toString().padLeft(2, '0')}-${_startDate.day.toString().padLeft(2, '0')}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _startDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date != null) {
                    setState(() {
                      _startDate = date;
                      if (_endDate.isBefore(_startDate)) {
                        _endDate = _startDate.add(const Duration(days: 7));
                      }
                    });
                  }
                },
                contentPadding: EdgeInsets.zero,
              ),

              // End Date
              ListTile(
                title: const Text('종료 날짜'),
                subtitle: Text('${_endDate.year}-${_endDate.month.toString().padLeft(2, '0')}-${_endDate.day.toString().padLeft(2, '0')}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _endDate,
                    firstDate: _startDate,
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date != null) {
                    setState(() {
                      _endDate = date;
                    });
                  }
                },
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 24),

              // Points
              Text(
                '포인트 설정',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              Slider(
                value: _points.toDouble(),
                min: 50,
                max: 500,
                divisions: 9,
                label: '$_points 점',
                onChanged: (value) {
                  setState(() {
                    _points = value.round();
                  });
                },
              ),
              Text(
                '완료시 획득 포인트: $_points 점',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Create Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _createChallenge,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    '챌린지 만들기',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createChallenge() async {
    if (_formKey.currentState!.validate()) {
      final challengeManager = ref.read(challengeManagerProvider.notifier);

      final challenge = await challengeManager.createPersonalChallenge(
        title: _titleController.text,
        description: _descriptionController.text,
        category: _selectedCategory,
        targetValue: int.parse(_targetValueController.text),
        unit: _unitController.text,
        startDate: _startDate,
        endDate: _endDate,
        points: _points,
      );

      if (mounted) {
        if (challenge != null) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('새 챌린지가 생성되었습니다!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('챌린지 생성에 실패했습니다')),
          );
        }
      }
    }
  }
}

