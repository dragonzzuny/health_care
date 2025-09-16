import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/sleep_providers.dart';
import '../models/sleep_data.dart';

class SleepScreen extends ConsumerStatefulWidget {
  const SleepScreen({super.key});

  @override
  ConsumerState<SleepScreen> createState() => _SleepScreenState();
}

class _SleepScreenState extends ConsumerState<SleepScreen> {
  @override
  Widget build(BuildContext context) {
    final isSleepingAsync = ref.watch(currentSleepStatusProvider);
    final currentSessionAsync = ref.watch(currentSleepSessionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('수면 관리'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showManualSleepEntryDialog(),
            tooltip: '수동 기록 추가',
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _showSleepGoalDialog(),
            tooltip: '수면 목표 설정',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 현재 수면 상태 카드
            isSleepingAsync.when(
              data: (isSleeping) => _buildCurrentSleepStatusCard(isSleeping, currentSessionAsync),
              loading: () => _buildLoadingCard(),
              error: (error, stack) => _buildErrorCard('수면 상태를 불러올 수 없습니다'),
            ),
            const SizedBox(height: 16),

            // 오늘의 수면 기록
            _buildTodaySleepCard(),
            const SizedBox(height: 16),

            // 주간 수면 통계
            _buildWeeklySleepStats(),
            const SizedBox(height: 16),

            // 수면 목표 vs 실제
            _buildSleepGoalCard(),
            const SizedBox(height: 16),

            // 최근 수면 히스토리
            _buildRecentSleepHistory(),
          ],
        ),
      ),
      floatingActionButton: isSleepingAsync.when(
        data: (isSleeping) => FloatingActionButton.extended(
          onPressed: () => isSleeping ? _showWakeUpDialog() : _startSleepTracking(),
          icon: Icon(isSleeping ? Icons.alarm : Icons.bedtime),
          label: Text(isSleeping ? '기상하기' : '잠자리'),
          backgroundColor: isSleeping ? Colors.orange : Colors.blue,
        ),
        loading: () => const CircularProgressIndicator(),
        error: (_, __) => FloatingActionButton(
          onPressed: () => ref.invalidate(currentSleepStatusProvider),
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }

  Widget _buildCurrentSleepStatusCard(bool isSleeping, AsyncValue<Map<String, dynamic>?> currentSessionAsync) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isSleeping ? Icons.bedtime : Icons.wb_sunny,
                  color: isSleeping ? Colors.blue : Colors.orange,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isSleeping ? '현재 수면 중' : '깨어있음',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isSleeping ? Colors.blue : Colors.orange,
                        ),
                      ),
                      if (isSleeping)
                        currentSessionAsync.when(
                          data: (session) {
                            if (session != null) {
                              final elapsedTime = session['elapsedTime'] as Duration;
                              return Text(
                                '수면 시간: ${_formatDuration(elapsedTime)}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              );
                            }
                            return const Text('수면 정보를 불러오는 중...');
                          },
                          loading: () => const Text('수면 정보를 불러오는 중...'),
                          error: (_, __) => const Text('수면 정보 오류'),
                        )
                      else
                        Text(
                          '잠자리에 들 준비가 되면 버튼을 눌러주세요',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodaySleepCard() {
    final todaySleepAsync = ref.watch(todaySleepProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '오늘의 수면',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            todaySleepAsync.when(
              data: (todaySleep) {
                if (todaySleep == null) {
                  return const Center(
                    child: Text('오늘의 수면 기록이 없습니다'),
                  );
                }

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildSleepStat(
                          '취침 시간',
                          _formatTime(todaySleep.bedTime),
                          Icons.bedtime,
                        ),
                        _buildSleepStat(
                          '기상 시간',
                          _formatTime(todaySleep.wakeTime),
                          Icons.wb_sunny,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildSleepStat(
                          '수면 시간',
                          _formatDuration(todaySleep.sleepDuration),
                          Icons.timer,
                        ),
                        _buildSleepStat(
                          '수면 질',
                          '${todaySleep.quality.emoji} ${todaySleep.quality.label}',
                          Icons.mood,
                        ),
                      ],
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => const Center(child: Text('데이터를 불러올 수 없습니다')),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklySleepStats() {
    final weeklyStatsAsync = ref.watch(weeklySleepStatsProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '이번 주 수면 통계',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            weeklyStatsAsync.when(
              data: (stats) {
                if (stats.totalSessions == 0) {
                  return const Center(
                    child: Text('이번 주 수면 기록이 없습니다'),
                  );
                }

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildSleepStat(
                          '평균 수면',
                          _formatDuration(stats.averageSleepDuration),
                          Icons.access_time,
                        ),
                        _buildSleepStat(
                          '총 수면 시간',
                          _formatDuration(stats.totalSleepTime),
                          Icons.schedule,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildSleepStat(
                          '수면 횟수',
                          '${stats.totalSessions}회',
                          Icons.format_list_numbered,
                        ),
                        _buildSleepStat(
                          '평균 수면 질',
                          '${stats.averageQualityScore.toStringAsFixed(1)}/5.0',
                          Icons.star,
                        ),
                      ],
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => const Center(child: Text('통계를 불러올 수 없습니다')),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSleepGoalCard() {
    final sleepGoalAsync = ref.watch(sleepGoalProvider);
    final goalAchievementAsync = ref.watch(sleepGoalAchievementProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '수면 목표',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            sleepGoalAsync.when(
              data: (goal) {
                if (goal == null) {
                  return Center(
                    child: Column(
                      children: [
                        const Text('설정된 수면 목표가 없습니다'),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () => _showSleepGoalDialog(),
                          child: const Text('목표 설정하기'),
                        ),
                      ],
                    ),
                  );
                }

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildSleepStat(
                          '목표 수면 시간',
                          _formatDuration(goal.targetSleepDuration),
                          Icons.flag,
                        ),
                        goalAchievementAsync.when(
                          data: (achievement) => _buildSleepStat(
                            '달성률',
                            '${(achievement * 100).round()}%',
                            Icons.track_changes,
                          ),
                          loading: () => _buildSleepStat('달성률', '계산 중...', Icons.track_changes),
                          error: (_, __) => _buildSleepStat('달성률', '오류', Icons.error),
                        ),
                      ],
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => const Center(child: Text('목표를 불러올 수 없습니다')),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSleepHistory() {
    final allSessionsAsync = ref.watch(allSleepSessionsProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '최근 수면 기록',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            allSessionsAsync.when(
              data: (sessions) {
                if (sessions.isEmpty) {
                  return const Center(
                    child: Text('수면 기록이 없습니다'),
                  );
                }

                final recentSessions = sessions.take(5).toList();
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: recentSessions.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final session = recentSessions[index];
                    return ListTile(
                      leading: Text(
                        session.quality.emoji,
                        style: const TextStyle(fontSize: 24),
                      ),
                      title: Text(_formatDate(session.bedTime)),
                      subtitle: Text('${_formatDuration(session.sleepDuration)} • ${session.quality.label}'),
                      trailing: session.isManualEntry
                          ? const Icon(Icons.edit, size: 16)
                          : null,
                      onTap: () => _showSleepDetailDialog(session),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => const Center(child: Text('기록을 불러올 수 없습니다')),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSleepStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingCard() {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildErrorCard(String message) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(child: Text(message)),
      ),
    );
  }

  Future<void> _startSleepTracking() async {
    final notifier = ref.read(sleepTrackerNotifierProvider.notifier);
    final sessionId = await notifier.startSleep();

    if (sessionId != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('수면 추적을 시작했습니다. 편안한 밤 되세요! 😴')),
      );
    }
  }

  Future<void> _showWakeUpDialog() async {
    SleepQuality? selectedQuality;

    final result = await showDialog<SleepQuality>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('기상하기'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('오늘 밤 수면의 질은 어떠셨나요?'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: SleepQuality.values.map((quality) {
                return ChoiceChip(
                  label: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(quality.emoji),
                      Text(quality.label, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                  selected: selectedQuality == quality,
                  onSelected: (selected) {
                    if (selected) {
                      selectedQuality = quality;
                      Navigator.of(context).pop(quality);
                    }
                  },
                );
              }).toList(),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
        ],
      ),
    );

    if (result != null) {
      final notifier = ref.read(sleepTrackerNotifierProvider.notifier);
      final session = await notifier.endSleep(result);

      if (session != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('좋은 아침입니다! 수면 시간: ${_formatDuration(session.sleepDuration)}'),
          ),
        );
      }
    }
  }

  Future<void> _showManualSleepEntryDialog() async {
    DateTime? bedTime;
    DateTime? wakeTime;
    SleepQuality? quality;
    String notes = '';

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('수면 기록 추가'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('취침 시간'),
                  subtitle: Text(bedTime != null ? _formatDateTime(bedTime!) : '선택하세요'),
                  trailing: const Icon(Icons.access_time),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now().subtract(const Duration(days: 1)),
                      firstDate: DateTime.now().subtract(const Duration(days: 30)),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: const TimeOfDay(hour: 23, minute: 0),
                      );
                      if (time != null) {
                        setState(() {
                          bedTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
                        });
                      }
                    }
                  },
                ),
                ListTile(
                  title: const Text('기상 시간'),
                  subtitle: Text(wakeTime != null ? _formatDateTime(wakeTime!) : '선택하세요'),
                  trailing: const Icon(Icons.wb_sunny),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: bedTime ?? DateTime.now(),
                      firstDate: bedTime ?? DateTime.now().subtract(const Duration(days: 30)),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: const TimeOfDay(hour: 7, minute: 0),
                      );
                      if (time != null) {
                        setState(() {
                          wakeTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
                        });
                      }
                    }
                  },
                ),
                const SizedBox(height: 16),
                const Text('수면 질'),
                Wrap(
                  spacing: 8,
                  children: SleepQuality.values.map((q) {
                    return ChoiceChip(
                      label: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(q.emoji),
                          Text(q.label, style: const TextStyle(fontSize: 10)),
                        ],
                      ),
                      selected: quality == q,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() => quality = q);
                        }
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('취소'),
            ),
            ElevatedButton(
              onPressed: bedTime != null && wakeTime != null && quality != null
                  ? () async {
                      final notifier = ref.read(sleepTrackerNotifierProvider.notifier);
                      await notifier.addManualSleepRecord(
                        bedTime: bedTime!,
                        wakeTime: wakeTime!,
                        quality: quality!,
                        notes: notes.isNotEmpty ? notes : null,
                      );
                      if (mounted) {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('수면 기록이 추가되었습니다')),
                        );
                      }
                    }
                  : null,
              child: const Text('저장'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showSleepGoalDialog() async {
    Duration targetSleep = const Duration(hours: 8);
    TimeOfDay targetBedTime = const TimeOfDay(hour: 23, minute: 0);
    TimeOfDay targetWakeTime = const TimeOfDay(hour: 7, minute: 0);

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('수면 목표 설정'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('목표 수면 시간'),
                subtitle: Text('${targetSleep.inHours}시간 ${targetSleep.inMinutes % 60}분'),
                trailing: const Icon(Icons.access_time),
                onTap: () async {
                  final hours = await showDialog<int>(
                    context: context,
                    builder: (context) => SimpleDialog(
                      title: const Text('수면 시간 (시간)'),
                      children: List.generate(12, (index) {
                        final hour = index + 4;
                        return SimpleDialogOption(
                          onPressed: () => Navigator.of(context).pop(hour),
                          child: Text('$hour시간'),
                        );
                      }),
                    ),
                  );
                  if (hours != null) {
                    setState(() {
                      targetSleep = Duration(hours: hours);
                    });
                  }
                },
              ),
              ListTile(
                title: const Text('목표 취침 시간'),
                subtitle: Text(targetBedTime.format(context)),
                trailing: const Icon(Icons.bedtime),
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: targetBedTime,
                  );
                  if (time != null) {
                    setState(() => targetBedTime = time);
                  }
                },
              ),
              ListTile(
                title: const Text('목표 기상 시간'),
                subtitle: Text(targetWakeTime.format(context)),
                trailing: const Icon(Icons.wb_sunny),
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: targetWakeTime,
                  );
                  if (time != null) {
                    setState(() => targetWakeTime = time);
                  }
                },
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
                final goal = SleepGoal(
                  targetSleepDuration: targetSleep,
                  targetBedTime: Duration(hours: targetBedTime.hour, minutes: targetBedTime.minute),
                  targetWakeTime: Duration(hours: targetWakeTime.hour, minutes: targetWakeTime.minute),
                  createdAt: DateTime.now(),
                );

                final notifier = ref.read(sleepTrackerNotifierProvider.notifier);
                await notifier.setSleepGoal(goal);

                if (mounted) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('수면 목표가 설정되었습니다')),
                  );
                }
              },
              child: const Text('저장'),
            ),
          ],
        ),
      ),
    );
  }

  void _showSleepDetailDialog(SleepSession session) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${_formatDate(session.bedTime)} 수면 기록'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDetailRow('취침 시간', _formatTime(session.bedTime)),
            _buildDetailRow('기상 시간', _formatTime(session.wakeTime)),
            _buildDetailRow('수면 시간', _formatDuration(session.sleepDuration)),
            _buildDetailRow('수면 질', '${session.quality.emoji} ${session.quality.label}'),
            if (session.notes != null)
              _buildDetailRow('메모', session.notes!),
            if (session.isManualEntry)
              const Row(
                children: [
                  Icon(Icons.edit, size: 16),
                  SizedBox(width: 8),
                  Text('수동 입력'),
                ],
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('닫기'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    return '$hours시간 $minutes분';
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _formatDate(DateTime dateTime) {
    return '${dateTime.month}월 ${dateTime.day}일';
  }

  String _formatDateTime(DateTime dateTime) {
    return '${_formatDate(dateTime)} ${_formatTime(dateTime)}';
  }
}