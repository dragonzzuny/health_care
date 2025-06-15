import 'package:flutter/material.dart';

class BodyScreen extends StatefulWidget {
  const BodyScreen({super.key});

  @override
  State<BodyScreen> createState() => _BodyScreenState();
}

class _BodyScreenState extends State<BodyScreen>
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
        title: const Text('신체 관리'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '체성분'),
            Tab(text: '운동'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBodyCompositionTab(),
          _buildExerciseTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddMeasurementDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBodyCompositionTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current Stats Card
          _buildCurrentStatsCard(),
          const SizedBox(height: 16),

          // Body Scan Section
          _buildBodyScanSection(),
          const SizedBox(height: 16),

          // Progress Chart
          _buildProgressChart(),
          const SizedBox(height: 16),

          // InBody Results
          _buildInBodyResults(),
        ],
      ),
    );
  }

  Widget _buildCurrentStatsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '현재 체성분',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    '체중',
                    '68.5',
                    'kg',
                    Icons.monitor_weight,
                    Colors.blue,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    'BMI',
                    '22.1',
                    '',
                    Icons.straighten,
                    Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    '체지방률',
                    '15.2',
                    '%',
                    Icons.pie_chart,
                    Colors.orange,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    '근육량',
                    '52.3',
                    'kg',
                    Icons.fitness_center,
                    Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String title, String value, String unit, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              if (unit.isNotEmpty)
                Text(
                  unit,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: color,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBodyScanSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '3D 체형 스캔',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.threed_rotation,
                    size: 48,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '체형 스캔하기',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '카메라를 이용해 정확한 체형을 측정해보세요',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('3D 체형 스캔 기능 준비 중입니다')),
                      );
                    },
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('스캔 시작'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressChart() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '체중 변화 추이',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: Center(
                child: Text(
                  '차트 영역\n(실제 구현 시 charts_flutter 패키지 사용)',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInBodyResults() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'InBody 결과',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('InBody OCR 기능 준비 중입니다')),
                    );
                  },
                  icon: const Icon(Icons.camera_alt, size: 16),
                  label: const Text('결과지 촬영'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInBodyItem('기초대사율', '1,456 kcal', '정상'),
            _buildInBodyItem('내장지방레벨', '3', '정상'),
            _buildInBodyItem('골격근량', '28.5 kg', '정상'),
            _buildInBodyItem('체수분', '42.1 L', '정상'),
          ],
        ),
      ),
    );
  }

  Widget _buildInBodyItem(String title, String value, String status) {
    Color statusColor = Colors.green;
    if (status == '주의') statusColor = Colors.orange;
    if (status == '위험') statusColor = Colors.red;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Today's Workout
          _buildTodayWorkout(),
          const SizedBox(height: 16),

          // Recommended Exercises
          _buildRecommendedExercises(),
          const SizedBox(height: 16),

          // Workout History
          _buildWorkoutHistory(),
        ],
      ),
    );
  }

  Widget _buildTodayWorkout() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '오늘의 운동',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.fitness_center,
                    size: 48,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '상체 근력 운동',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '예상 소요시간: 45분',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('운동 시작 기능 준비 중입니다')),
                      );
                    },
                    child: const Text('운동 시작'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendedExercises() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '추천 운동',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildExerciseItem(
              '푸시업',
              '가슴, 어깨, 삼두근',
              '15회 x 3세트',
              Icons.fitness_center,
              Colors.blue,
            ),
            _buildExerciseItem(
              '스쿼트',
              '하체 전체',
              '20회 x 3세트',
              Icons.accessibility_new,
              Colors.green,
            ),
            _buildExerciseItem(
              '플랭크',
              '코어',
              '30초 x 3세트',
              Icons.self_improvement,
              Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseItem(String name, String target, String sets, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
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
                  name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  target,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(
            sets,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutHistory() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '운동 기록',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final workouts = [
                  {'name': '상체 근력 운동', 'date': '어제', 'duration': '45분'},
                  {'name': '유산소 운동', 'date': '2일 전', 'duration': '30분'},
                  {'name': '하체 근력 운동', 'date': '3일 전', 'duration': '50분'},
                  {'name': '요가', 'date': '4일 전', 'duration': '60분'},
                  {'name': '전신 운동', 'date': '5일 전', 'duration': '40분'},
                ];

                final workout = workouts[index];

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    child: Icon(
                      Icons.fitness_center,
                      color: Theme.of(context).colorScheme.primary,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    workout['name']!,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(workout['date']!),
                  trailing: Text(
                    workout['duration']!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAddMeasurementDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('측정 데이터 추가'),
        content: const Text('체중, 체지방률 등의 측정 데이터를 추가하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('측정 데이터 입력 기능 준비 중입니다')),
              );
            },
            child: const Text('추가'),
          ),
        ],
      ),
    );
  }
}

