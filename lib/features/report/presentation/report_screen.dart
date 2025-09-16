import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/report_providers.dart';

class ReportScreen extends ConsumerStatefulWidget {
  const ReportScreen({super.key});

  @override
  ConsumerState<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends ConsumerState<ReportScreen>
    with TickerProviderStateMixin {
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
    final activityReport = ref.watch(weeklyActivityReportProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          activityReport.when(
            data: (report) => _buildSummaryCard(
              '이번 주 활동 요약',
              [
                _buildSummaryItem(
                  '평균 걸음 수',
                  _formatNumber(report['avgSteps']),
                  '목표 대비 ${(report['stepsProgress'] * 100).round()}%',
                  Colors.blue,
                ),
                _buildSummaryItem(
                  '총 운동 시간',
                  _formatDuration(report['totalActiveMinutes']),
                  '목표 대비 ${(report['activeMinutesProgress'] * 100).round()}%',
                  Colors.green,
                ),
                _buildSummaryItem(
                  '소모 칼로리',
                  '${_formatNumber(report['totalCalories'])} kcal',
                  '목표 대비 ${(report['caloriesProgress'] * 100).round()}%',
                  Colors.orange,
                ),
              ],
            ),
            loading: () => _buildLoadingSummaryCard('이번 주 활동 요약'),
            error: (_, __) => _buildErrorSummaryCard('이번 주 활동 요약'),
          ),
          const SizedBox(height: 16),
          activityReport.when(
            data: (report) => _buildChartCard(
              '일별 걸음 수',
              SizedBox(
                height: 200,
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: true),
                    titlesData: FlTitlesData(
                      leftTitles: const AxisTitles(
                        sideTitles:
                            SideTitles(showTitles: true, reservedSize: 40),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const days = ['월', '화', '수', '목', '금', '토', '일'];
                            if (value.toInt() >= 0 &&
                                value.toInt() < days.length) {
                              return Text(days[value.toInt()]);
                            }
                            return const Text('');
                          },
                        ),
                      ),
                      topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(show: true),
                    lineBarsData: [
                      LineChartBarData(
                        spots:
                            _generateStepsChartSpots(report['dailyStepsData']),
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
            loading: () => _buildLoadingChart('일별 걸음 수'),
            error: (_, __) => _buildErrorChart('일별 걸음 수'),
          ),
          const SizedBox(height: 16),
          Consumer(
            builder: (context, ref, child) {
              final workoutDistribution =
                  ref.watch(workoutTypeDistributionProvider);

              return workoutDistribution.when(
                data: (distribution) => _buildChartCard(
                  '운동 유형별 분포',
                  SizedBox(
                    height: 200,
                    child: PieChart(
                      PieChartData(
                        sections:
                            _generateWorkoutPieChartSections(distribution),
                        centerSpaceRadius: 40,
                      ),
                    ),
                  ),
                ),
                loading: () => _buildLoadingChart('운동 유형별 분포'),
                error: (_, __) => _buildErrorChart('운동 유형별 분포'),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionReport() {
    final nutritionReport = ref.watch(weeklyNutritionReportProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          nutritionReport.when(
            data: (report) => _buildSummaryCard(
              '이번 주 영양 요약',
              [
                _buildSummaryItem(
                  '평균 칼로리',
                  '${_formatNumber(report['avgCalories'])} kcal',
                  '목표 대비 ${(report['calorieProgress'] * 100).round()}%',
                  Colors.red,
                ),
                _buildSummaryItem(
                  '단백질 섭취',
                  '${report['avgProtein']}g',
                  '목표 대비 ${(report['proteinProgress'] * 100).round()}%',
                  Colors.blue,
                ),
                _buildSummaryItem(
                  '수분 섭취',
                  '${report['waterIntake']}L',
                  '목표 대비 ${(report['waterProgress'] * 100).round()}%',
                  Colors.cyan,
                ),
              ],
            ),
            loading: () => _buildLoadingSummaryCard('이번 주 영양 요약'),
            error: (_, __) => _buildErrorSummaryCard('이번 주 영양 요약'),
          ),
          const SizedBox(height: 16),
          nutritionReport.when(
            data: (report) => _buildChartCard(
              '일별 칼로리 섭취',
              SizedBox(
                height: 200,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: _getMaxCalorie(report['dailyCaloriesData']) * 1.2,
                    titlesData: FlTitlesData(
                      leftTitles: const AxisTitles(
                        sideTitles:
                            SideTitles(showTitles: true, reservedSize: 40),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const days = ['월', '화', '수', '목', '금', '토', '일'];
                            if (value.toInt() >= 0 &&
                                value.toInt() < days.length) {
                              return Text(days[value.toInt()]);
                            }
                            return const Text('');
                          },
                        ),
                      ),
                      topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(show: true),
                    barGroups: _generateCalorieBarChartGroups(
                        report['dailyCaloriesData']),
                  ),
                ),
              ),
            ),
            loading: () => _buildLoadingChart('일별 칼로리 섭취'),
            error: (_, __) => _buildErrorChart('일별 칼로리 섭취'),
          ),
          const SizedBox(height: 16),
          nutritionReport.when(
            data: (report) => _buildChartCard(
              '영양소 균형',
              SizedBox(
                height: 200,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: (report['carbsRatio'] * 100),
                        title: '탄수화물\n${(report['carbsRatio'] * 100).round()}%',
                        color: Colors.amber,
                        radius: 80,
                      ),
                      PieChartSectionData(
                        value: (report['proteinRatio'] * 100),
                        title:
                            '단백질\n${(report['proteinRatio'] * 100).round()}%',
                        color: Colors.red,
                        radius: 80,
                      ),
                      PieChartSectionData(
                        value: (report['fatRatio'] * 100),
                        title: '지방\n${(report['fatRatio'] * 100).round()}%',
                        color: Colors.blue,
                        radius: 80,
                      ),
                    ],
                    centerSpaceRadius: 40,
                  ),
                ),
              ),
            ),
            loading: () => _buildLoadingChart('영양소 균형'),
            error: (_, __) => _buildErrorChart('영양소 균형'),
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
              _buildSummaryItem(
                  '평균 수면 시간', '7시간 23분', '목표 대비 98%', Colors.indigo),
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
                      sideTitles:
                          SideTitles(showTitles: true, reservedSize: 40),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const days = ['월', '화', '수', '목', '금', '토', '일'];
                          if (value.toInt() >= 0 &&
                              value.toInt() < days.length) {
                            return Text(days[value.toInt()]);
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
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
    final healthScore = ref.watch(healthScoreProvider);

    return healthScore.when(
      data: (score) => Card(
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
                        value: score['overall'] / 100.0,
                        strokeWidth: 12,
                        backgroundColor: Colors.grey.shade300,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            _getScoreColor(score['overall'])),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${score['overall']}',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: _getScoreColor(score['overall']),
                                  ),
                            ),
                            Text(
                              '점',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: _getScoreColor(score['overall']),
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
                  _buildScoreItem('활동', score['activity'], Colors.blue),
                  _buildScoreItem('식단', score['nutrition'], Colors.green),
                  _buildScoreItem('수면', score['sleep'], Colors.indigo),
                ],
              ),
            ],
          ),
        ),
      ),
      loading: () => _buildLoadingHealthScoreCard(),
      error: (_, __) => _buildErrorHealthScoreCard(),
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
    final aiInsights = ref.watch(aiInsightsProvider);

    return aiInsights.when(
      data: (insights) => Card(
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
              ...insights.asMap().entries.map((entry) {
                final index = entry.key;
                final insight = entry.value;

                return Column(
                  children: [
                    if (index > 0) const SizedBox(height: 12),
                    _buildInsightItem(
                      insight['title'],
                      insight['description'],
                      _getIconFromString(insight['icon']),
                      _getColorFromString(insight['color']),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
      loading: () => _buildLoadingInsightsCard(),
      error: (_, __) => _buildErrorInsightsCard(),
    );
  }

  Widget _buildInsightItem(
      String title, String description, IconData icon, Color color) {
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
    final goalAchievement = ref.watch(goalAchievementProvider);

    return goalAchievement.when(
      data: (goals) => Card(
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
              ...goals.asMap().entries.map((entry) {
                final index = entry.key;
                final goal = entry.value;

                return Column(
                  children: [
                    if (index > 0) const SizedBox(height: 12),
                    _buildProgressItem(
                      goal['title'],
                      goal['progress'],
                      '${_formatGoalValue(goal['current'], goal['unit'])} / ${_formatGoalValue(goal['target'], goal['unit'])}',
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
      loading: () => _buildLoadingGoalProgressCard(),
      error: (_, __) => _buildErrorGoalProgressCard(),
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
    final recommendations = ref.watch(recommendationsProvider);

    return recommendations.when(
      data: (recs) => Card(
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
              ...recs.asMap().entries.map((entry) {
                final index = entry.key;
                final rec = entry.value;

                return Column(
                  children: [
                    if (index > 0) const SizedBox(height: 12),
                    _buildRecommendationItem(
                      rec['category'],
                      rec['recommendation'],
                      _getIconFromString(rec['icon']),
                      _getColorFromString(rec['color']),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
      loading: () => _buildLoadingRecommendationsCard(),
      error: (_, __) => _buildErrorRecommendationsCard(),
    );
  }

  Widget _buildRecommendationItem(
      String category, String recommendation, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
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

  Widget _buildSummaryItem(
      String label, String value, String subtitle, Color color) {
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

  // 헬퍼 메서드들

  /// 숫자 포매팅
  String _formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    }
    return number.toString();
  }

  /// 시간 포매팅 (분 -> 시간/분)
  String _formatDuration(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    if (hours > 0) {
      return '$hours시간 $mins분';
    }
    return '$mins분';
  }

  /// 목표값 포매팅
  String _formatGoalValue(dynamic value, String unit) {
    if (value is double) {
      if (unit == '시간') {
        return value.toStringAsFixed(1);
      }
      return value.toStringAsFixed(1);
    }
    return value.toString();
  }

  /// 점수 색상 결정
  Color _getScoreColor(int score) {
    if (score >= 85) return Colors.green;
    if (score >= 70) return Colors.orange;
    return Colors.red;
  }

  /// 문자열을 아이콘으로 변환
  IconData _getIconFromString(String iconName) {
    switch (iconName) {
      case 'fitness_center':
        return Icons.fitness_center;
      case 'restaurant':
        return Icons.restaurant;
      case 'bedtime':
        return Icons.bedtime;
      case 'directions_walk':
        return Icons.directions_walk;
      case 'water_drop':
        return Icons.water_drop;
      default:
        return Icons.info;
    }
  }

  /// 문자열을 색상으로 변환
  Color _getColorFromString(String colorName) {
    switch (colorName) {
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'orange':
        return Colors.orange;
      case 'red':
        return Colors.red;
      case 'indigo':
        return Colors.indigo;
      case 'purple':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  /// 걸음 수 차트 스팟 생성
  List<FlSpot> _generateStepsChartSpots(List<double> stepsData) {
    return stepsData.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value);
    }).toList();
  }

  /// 운동 타입별 파이차트 섹션 생성
  List<PieChartSectionData> _generateWorkoutPieChartSections(
      List<Map<String, dynamic>> distribution) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.purple,
      Colors.orange,
      Colors.red,
      Colors.cyan
    ];

    return distribution.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      final color = colors[index % colors.length];

      return PieChartSectionData(
        value: item['value'],
        title: '${item['type']}\n${item['value'].round()}%',
        color: color,
        radius: 80,
      );
    }).toList();
  }

  /// 칼로리 바차트 그룹 생성
  List<BarChartGroupData> _generateCalorieBarChartGroups(
      List<double> caloriesData) {
    return caloriesData.asMap().entries.map((entry) {
      return BarChartGroupData(
        x: entry.key,
        barRods: [
          BarChartRodData(
            toY: entry.value,
            color: Colors.green,
          ),
        ],
      );
    }).toList();
  }

  /// 칼로리 데이터에서 최대값 구하기
  double _getMaxCalorie(List<double> caloriesData) {
    if (caloriesData.isEmpty) return 2500.0;
    return caloriesData.reduce((a, b) => a > b ? a : b);
  }

  // 로딩 상태 카드들

  Widget _buildLoadingSummaryCard(String title) {
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
            const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingChart(String title) {
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
            const SizedBox(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingHealthScoreCard() {
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
            const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingInsightsCard() {
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
            const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingGoalProgressCard() {
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
            const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingRecommendationsCard() {
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
            const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }

  // 에러 상태 카드들

  Widget _buildErrorSummaryCard(String title) {
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
            Center(
              child: Column(
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 48),
                  const SizedBox(height: 8),
                  Text(
                    '데이터를 불러올 수 없습니다',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorChart(String title) {
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
            SizedBox(
              height: 200,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, color: Colors.red, size: 48),
                    const SizedBox(height: 8),
                    Text(
                      '차트를 불러올 수 없습니다',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorHealthScoreCard() {
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
              child: Column(
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 48),
                  const SizedBox(height: 8),
                  Text(
                    '건강 점수를 계산할 수 없습니다',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorInsightsCard() {
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
            Center(
              child: Column(
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 48),
                  const SizedBox(height: 8),
                  Text(
                    'AI 인사이트를 불러올 수 없습니다',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorGoalProgressCard() {
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
            Center(
              child: Column(
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 48),
                  const SizedBox(height: 8),
                  Text(
                    '목표 달성률을 불러올 수 없습니다',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorRecommendationsCard() {
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
            Center(
              child: Column(
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 48),
                  const SizedBox(height: 8),
                  Text(
                    '권장사항을 불러올 수 없습니다',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
