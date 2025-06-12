import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class ReportScreen extends ConsumerStatefulWidget {
  const ReportScreen({super.key});

  @override
  ConsumerState<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends ConsumerState<ReportScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
        title: const Text('건강 리포트'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('리포트 공유 기능 준비 중입니다')),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '활동'),
            Tab(text: '식단'),
            Tab(text: '수면'),
            Tab(text: '종합'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildActivityReport(),
          _buildNutritionReport(),
          _buildSleepReport(),
          _buildOverallReport(),
        ],
      ),
    );
  }

  Widget _buildActivityReport() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryCard(
            '이번 주 활동 요약',
            [
              _buildSummaryItem('평균 걸음 수', '8,542', '목표 대비 85%', Colors.blue),
              _buildSummaryItem('총 운동 시간', '4시간 32분', '목표 대비 91%', Colors.green),
              _buildSummaryItem('소모 칼로리', '2,847 kcal', '목표 대비 95%', Colors.orange),
            ],
          ),
          const SizedBox(height: 16),
          
          _buildChartCard(
            '일별 걸음 수',
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const days = ['월', '화', '수', '목', '금', '토', '일'];
                          if (value.toInt() >= 0 && value.toInt() < days.length) {
                            return Text(days[value.toInt()]);
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        const FlSpot(0, 7500),
                        const FlSpot(1, 8200),
                        const FlSpot(2, 9100),
                        const FlSpot(3, 8800),
                        const FlSpot(4, 9500),
                        const FlSpot(5, 7800),
                        const FlSpot(6, 8900),
                      ],
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      dotData: const FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          _buildChartCard(
            '운동 유형별 분포',
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: 40,
                      title: '유산소\n40%',
                      color: Colors.blue,
                      radius: 80,
                    ),
                    PieChartSectionData(
                      value: 30,
                      title: '근력\n30%',
                      color: Colors.green,
                      radius: 80,
                    ),
                    PieChartSectionData(
                      value: 20,
                      title: '요가\n20%',
                      color: Colors.purple,
                      radius: 80,
                    ),
                    PieChartSectionData(
                      value: 10,
                      title: '기타\n10%',
                      color: Colors.orange,
                      radius: 80,
                    ),
                  ],
                  centerSpaceRadius: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionReport() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryCard(
            '이번 주 영양 요약',
            [
              _buildSummaryItem('평균 칼로리', '1,847 kcal', '목표 대비 92%', Colors.red),
              _buildSummaryItem('단백질 섭취', '78g', '목표 대비 104%', Colors.blue),
              _buildSummaryItem('수분 섭취', '1.8L', '목표 대비 90%', Colors.cyan),
            ],
          ),
          const SizedBox(height: 16),
          
          _buildChartCard(
            '일별 칼로리 섭취',
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 2500,
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const days = ['월', '화', '수', '목', '금', '토', '일'];
                          if (value.toInt() >= 0 && value.toInt() < days.length) {
                            return Text(days[value.toInt()]);
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: true),
                  barGroups: [
                    BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 1800, color: Colors.green)]),
                    BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 1950, color: Colors.green)]),
                    BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 1750, color: Colors.green)]),
                    BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 2100, color: Colors.green)]),
                    BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 1850, color: Colors.green)]),
                    BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 2200, color: Colors.green)]),
                    BarChartGroupData(x: 6, barRods: [BarChartRodData(toY: 1900, color: Colors.green)]),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          _buildChartCard(
            '영양소 균형',
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: 50,
                      title: '탄수화물\n50%',
                      color: Colors.amber,
                      radius: 80,
                    ),
                    PieChartSectionData(
                      value: 25,
                      title: '단백질\n25%',
                      color: Colors.red,
                      radius: 80,
                    ),
                    PieChartSectionData(
                      value: 25,
                      title: '지방\n25%',
                      color: Colors.blue,
                      radius: 80,
                    ),
                  ],
                  centerSpaceRadius: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSleepReport() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryCard(
            '이번 주 수면 요약',
            [
              _buildSummaryItem('평균 수면 시간', '7시간 23분', '목표 대비 98%', Colors.indigo),
              _buildSummaryItem('수면 효율성', '87%', '양호', Colors.green),
              _buildSummaryItem('깊은 잠 비율', '23%', '정상 범위', Colors.purple),
            ],
          ),
          const SizedBox(height: 16),
          
          _buildChartCard(
            '일별 수면 시간',
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const days = ['월', '화', '수', '목', '금', '토', '일'];
                          if (value.toInt() >= 0 && value.toInt() < days.length) {
                            return Text(days[value.toInt()]);
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        const FlSpot(0, 7.5),
                        const FlSpot(1, 6.8),
                        const FlSpot(2, 7.2),
                        const FlSpot(3, 8.1),
                        const FlSpot(4, 7.0),
                        const FlSpot(5, 8.5),
                        const FlSpot(6, 7.8),
                      ],
                      isCurved: true,
                      color: Colors.indigo,
                      barWidth: 3,
                      dotData: const FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverallReport() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHealthScoreCard(),
          const SizedBox(height: 16),
          _buildAIInsightsCard(),
          const SizedBox(height: 16),
          _buildGoalProgressCard(),
          const SizedBox(height: 16),
          _buildRecommendationsCard(),
        ],
      ),
    );
  }

  Widget _buildHealthScoreCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '종합 건강 점수',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: 150,
                height: 150,
                child: Stack(
                  children: [
                    CircularProgressIndicator(
                      value: 0.85,
                      strokeWidth: 12,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '85',
                            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          Text(
                            '점',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildScoreItem('활동', 88, Colors.blue),
                _buildScoreItem('식단', 82, Colors.green),
                _buildScoreItem('수면', 85, Colors.indigo),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreItem(String label, int score, Color color) {
    return Column(
      children: [
        Text(
          '$score',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildAIInsightsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.psychology,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'AI 인사이트',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInsightItem(
              '운동 패턴 분석',
              '주말에 운동량이 증가하는 패턴을 보입니다. 평일 운동 시간을 늘리면 더 균형잡힌 활동이 가능할 것 같습니다.',
              Icons.fitness_center,
              Colors.blue,
            ),
            const SizedBox(height: 12),
            _buildInsightItem(
              '수면 품질 개선',
              '수요일과 목요일에 수면 시간이 부족합니다. 이 날들의 취침 시간을 30분 앞당기는 것을 권장합니다.',
              Icons.bedtime,
              Colors.indigo,
            ),
            const SizedBox(height: 12),
            _buildInsightItem(
              '영양 균형',
              '단백질 섭취량이 목표를 초과하고 있어 좋습니다. 다만 수분 섭취를 조금 더 늘리시면 좋겠습니다.',
              Icons.restaurant,
              Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightItem(String title, String description, IconData icon, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGoalProgressCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '목표 달성률',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildProgressItem('일일 걸음 수', 0.85, '8,500 / 10,000'),
            const SizedBox(height: 12),
            _buildProgressItem('주간 운동 시간', 0.91, '4.5시간 / 5시간'),
            const SizedBox(height: 12),
            _buildProgressItem('수분 섭취량', 0.90, '1.8L / 2L'),
            const SizedBox(height: 12),
            _buildProgressItem('수면 시간', 0.98, '7.3시간 / 7.5시간'),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressItem(String title, double progress, String detail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${(progress * 100).toInt()}%',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: progress >= 0.9 ? Colors.green : Colors.orange,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey.shade300,
          valueColor: AlwaysStoppedAnimation<Color>(
            progress >= 0.9 ? Colors.green : Colors.orange,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          detail,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '개인 맞춤 권장사항',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildRecommendationItem(
              '운동',
              '평일 점심시간에 15분 산책을 추가해보세요',
              Icons.directions_walk,
              Colors.blue,
            ),
            const SizedBox(height: 12),
            _buildRecommendationItem(
              '식단',
              '오후 간식으로 견과류를 섭취하면 좋겠습니다',
              Icons.restaurant,
              Colors.green,
            ),
            const SizedBox(height: 12),
            _buildRecommendationItem(
              '수면',
              '취침 1시간 전 스마트폰 사용을 줄여보세요',
              Icons.bedtime,
              Colors.indigo,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationItem(String category, String recommendation, IconData icon, Color color) {
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
                category,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                recommendation,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, List<Widget> items) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...items,
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, String subtitle, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartCard(String title, Widget chart) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            chart,
          ],
        ),
      ),
    );
  }
}

