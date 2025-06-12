import 'package:flutter/material.dart';

class SleepScreen extends StatefulWidget {
  const SleepScreen({super.key});

  @override
  State<SleepScreen> createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('수면 관리'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Navigate to sleep settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Last Night Sleep Card
            _buildLastNightSleepCard(),
            const SizedBox(height: 16),

            // Sleep Quality Chart
            _buildSleepQualityChart(),
            const SizedBox(height: 16),

            // Sleep Stages
            _buildSleepStages(),
            const SizedBox(height: 16),

            // Sleep Tips
            _buildSleepTips(),
            const SizedBox(height: 16),

            // Sleep History
            _buildSleepHistory(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showSleepTrackingDialog();
        },
        child: const Icon(Icons.bedtime),
      ),
    );
  }

  Widget _buildLastNightSleepCard() {
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.indigo.shade400,
              Colors.purple.shade400,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.bedtime,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  '어젯밤 수면',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '총 수면시간',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      Text(
                        '7시간 32분',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '좋음',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildSleepStat('취침', '23:15', Icons.nightlight_round),
                const SizedBox(width: 24),
                _buildSleepStat('기상', '06:47', Icons.wb_sunny),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSleepStat(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.white.withOpacity(0.8), size: 16),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 12,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSleepQualityChart() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '수면 품질 추이',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              child: Center(
                child: Text(
                  '수면 품질 차트\n(실제 구현 시 charts_flutter 패키지 사용)',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildQualityIndicator('깊은 잠', '2h 15m', Colors.indigo),
                _buildQualityIndicator('얕은 잠', '4h 32m', Colors.blue),
                _buildQualityIndicator('REM', '55m', Colors.purple),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQualityIndicator(String label, String value, Color color) {
    return Column(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildSleepStages() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '수면 단계 분석',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildStageItem(
              '깊은 잠 (Deep Sleep)',
              '2시간 15분',
              '전체의 30%',
              0.3,
              Colors.indigo,
              '충분함',
            ),
            const SizedBox(height: 12),
            _buildStageItem(
              '얕은 잠 (Light Sleep)',
              '4시간 32분',
              '전체의 60%',
              0.6,
              Colors.blue,
              '정상',
            ),
            const SizedBox(height: 12),
            _buildStageItem(
              'REM 수면',
              '55분',
              '전체의 12%',
              0.12,
              Colors.purple,
              '부족',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStageItem(
    String title,
    String duration,
    String percentage,
    double progress,
    Color color,
    String status,
  ) {
    Color statusColor = Colors.green;
    if (status == '부족') statusColor = Colors.orange;
    if (status == '매우 부족') statusColor = Colors.red;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
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
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              duration,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              percentage,
              style: Theme.of(context).textTheme.bodySmall,
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
    );
  }

  Widget _buildSleepTips() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '수면 개선 팁',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildTipItem(
              '규칙적인 수면 패턴',
              '매일 같은 시간에 잠자리에 들고 일어나세요',
              Icons.schedule,
              Colors.blue,
            ),
            const SizedBox(height: 12),
            _buildTipItem(
              '취침 전 스크린 타임 줄이기',
              '잠자리에 들기 1시간 전부터는 스마트폰을 멀리하세요',
              Icons.phone_android,
              Colors.orange,
            ),
            const SizedBox(height: 12),
            _buildTipItem(
              '적절한 실내 온도',
              '18-22도의 시원한 환경에서 잠을 자세요',
              Icons.thermostat,
              Colors.cyan,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipItem(String title, String description, IconData icon, Color color) {
    return Row(
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
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSleepHistory() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '수면 기록',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 7,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final sleepData = [
                  {'date': '어제', 'duration': '7h 32m', 'quality': '좋음', 'color': Colors.green},
                  {'date': '2일 전', 'duration': '6h 45m', 'quality': '보통', 'color': Colors.orange},
                  {'date': '3일 전', 'duration': '8h 15m', 'quality': '매우 좋음', 'color': Colors.green},
                  {'date': '4일 전', 'duration': '5h 30m', 'quality': '나쁨', 'color': Colors.red},
                  {'date': '5일 전', 'duration': '7h 20m', 'quality': '좋음', 'color': Colors.green},
                  {'date': '6일 전', 'duration': '6h 55m', 'quality': '보통', 'color': Colors.orange},
                  {'date': '7일 전', 'duration': '7h 45m', 'quality': '좋음', 'color': Colors.green},
                ];

                final sleep = sleepData[index];

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: (sleep['color'] as Color).withOpacity(0.1),
                    child: Icon(
                      Icons.bedtime,
                      color: sleep['color'] as Color,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    sleep['date'] as String,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(sleep['duration'] as String),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: (sleep['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      sleep['quality'] as String,
                      style: TextStyle(
                        color: sleep['color'] as Color,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
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

  void _showSleepTrackingDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '수면 추적',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('수면 추적을 시작합니다')),
                      );
                    },
                    icon: const Icon(Icons.bedtime),
                    label: const Text('수면 시작'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('수동 입력 기능 준비 중입니다')),
                      );
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('수동 입력'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

