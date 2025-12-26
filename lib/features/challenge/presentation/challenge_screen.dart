import 'package:flutter/material.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({super.key});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: '진행 중'),
            Tab(text: '리더보드'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildActiveChallenges(),
          _buildLeaderboard(),
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

  Widget _buildActiveChallenges() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Daily Challenges
          Text(
            '오늘의 챌린지',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildChallengeCard(
            title: '10,000걸음 걷기',
            description: '하루 만보 걷기 챌린지',
            progress: 0.72,
            currentValue: '7,234',
            targetValue: '10,000',
            unit: '걸음',
            icon: Icons.directions_walk,
            color: Colors.blue,
            isCompleted: false,
          ),
          const SizedBox(height: 12),
          _buildChallengeCard(
            title: '물 2L 마시기',
            description: '충분한 수분 섭취하기',
            progress: 0.6,
            currentValue: '1.2',
            targetValue: '2.0',
            unit: 'L',
            icon: Icons.water_drop,
            color: Colors.cyan,
            isCompleted: false,
          ),
          const SizedBox(height: 24),

          // Weekly Challenges
          Text(
            '주간 챌린지',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildChallengeCard(
            title: '주 3회 운동하기',
            description: '일주일에 3번 이상 운동하기',
            progress: 0.67,
            currentValue: '2',
            targetValue: '3',
            unit: '회',
            icon: Icons.fitness_center,
            color: Colors.orange,
            isCompleted: false,
          ),
          const SizedBox(height: 12),
          _buildChallengeCard(
            title: '건강한 식단 유지',
            description: '매일 균형잡힌 식사하기',
            progress: 1.0,
            currentValue: '7',
            targetValue: '7',
            unit: '일',
            icon: Icons.restaurant,
            color: Colors.green,
            isCompleted: true,
          ),
          const SizedBox(height: 24),

          // Personal Challenges
          Text(
            '개인 챌린지',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildChallengeCard(
            title: '금연 30일',
            description: '건강한 생활을 위한 금연',
            progress: 0.5,
            currentValue: '15',
            targetValue: '30',
            unit: '일',
            icon: Icons.smoke_free,
            color: Colors.red,
            isCompleted: false,
          ),
        ],
      ),
    );
  }

  Widget _buildChallengeCard({
    required String title,
    required String description,
    required double progress,
    required String currentValue,
    required String targetValue,
    required String unit,
    required IconData icon,
    required Color color,
    required bool isCompleted,
  }) {
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
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isCompleted)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
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
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$currentValue / $targetValue $unit',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  '${(progress * 100).toInt()}%',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: color.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderboard() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top 3 Podium
          _buildPodium(),
          const SizedBox(height: 24),

          // Leaderboard List
          Text(
            '전체 순위',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final users = [
                  {'name': '김건강', 'score': 2450, 'avatar': '🏃‍♂️'},
                  {'name': '이운동', 'score': 2380, 'avatar': '💪'},
                  {'name': '박활력', 'score': 2320, 'avatar': '🚴‍♀️'},
                  {'name': '최웰빙', 'score': 2280, 'avatar': '🏊‍♂️'},
                  {'name': '정헬스', 'score': 2240, 'avatar': '🧘‍♀️'},
                  {'name': '강체력', 'score': 2200, 'avatar': '🏋️‍♂️'},
                  {'name': '윤건강', 'score': 2150, 'avatar': '🚶‍♀️'},
                  {'name': '나활동', 'score': 2100, 'avatar': '🏃‍♀️'},
                  {'name': '당신', 'score': 2050, 'avatar': '😊'},
                  {'name': '조운동', 'score': 2000, 'avatar': '🤸‍♂️'},
                ];

                final user = users[index];
                final rank = index + 4; // Starting from 4th place

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    child: Text(
                      user['avatar'] as String,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  title: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: rank <= 3 
                              ? Colors.amber.withOpacity(0.2)
                              : Theme.of(context).colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            '$rank',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: rank <= 3 ? Colors.amber[700] : null,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        user['name'] as String,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${user['score']} 점',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        '이번 주',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPodium() {
    return SizedBox(
      height: 200,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 2nd Place
          Expanded(
            child: _buildPodiumPlace(
              rank: 2,
              name: '이운동',
              score: 2380,
              avatar: '💪',
              height: 120,
              color: Colors.grey[400]!,
            ),
          ),
          // 1st Place
          Expanded(
            child: _buildPodiumPlace(
              rank: 1,
              name: '김건강',
              score: 2450,
              avatar: '🏃‍♂️',
              height: 160,
              color: Colors.amber,
            ),
          ),
          // 3rd Place
          Expanded(
            child: _buildPodiumPlace(
              rank: 3,
              name: '박활력',
              score: 2320,
              avatar: '🚴‍♀️',
              height: 100,
              color: Colors.brown[400]!,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPodiumPlace({
    required int rank,
    required String name,
    required int score,
    required String avatar,
    required double height,
    required Color color,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Avatar and Info
        CircleAvatar(
          radius: 24,
          backgroundColor: color.withOpacity(0.2),
          child: Text(avatar, style: const TextStyle(fontSize: 24)),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          '$score점',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        
        // Podium
        Container(
          height: height,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
          ),
          child: Center(
            child: Text(
              '$rank',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showCreateChallengeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('새 챌린지 만들기'),
        content: const Text('개인 맞춤 챌린지를 만들어보세요!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('챌린지 생성 기능 준비 중입니다')),
              );
            },
            child: const Text('만들기'),
          ),
        ],
      ),
    );
  }
}

