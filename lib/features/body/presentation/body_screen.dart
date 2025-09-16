import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:io';
import '../../body_composition/providers/body_composition_providers.dart';
import '../../body_composition/models/body_composition_data.dart';

class BodyScreen extends ConsumerStatefulWidget {
  const BodyScreen({super.key});

  @override
  ConsumerState<BodyScreen> createState() => _BodyScreenState();
}

class _BodyScreenState extends ConsumerState<BodyScreen>
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
        title: const Text('신체 관리'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '체성분분석'),
            Tab(text: '현재 나의 신체'),
            Tab(text: '운동루틴'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBodyCompositionTab(),
          _buildCurrentBodyTab(),
          _buildWorkoutRoutineTab(),
        ],
      ),
      floatingActionButton: _tabController.index == 0
          ? FloatingActionButton(
              onPressed: _showAddMeasurementDialog,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  // 체성분분석 탭
  Widget _buildBodyCompositionTab() {
    return Consumer(
      builder: (context, ref, child) {
        final latestCompositionAsync = ref.watch(latestBodyCompositionProvider);
        final compositionsAsync = ref.watch(bodyCompositionsProvider);
        final statsAsync = ref.watch(bodyCompositionStatsProvider);

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(latestBodyCompositionProvider);
            ref.invalidate(bodyCompositionsProvider);
            ref.invalidate(bodyCompositionStatsProvider);
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // 최근 측정 결과
                latestCompositionAsync.when(
                  data: (composition) => composition != null
                      ? _buildLatestMeasurementCard(composition)
                      : _buildNoDataCard(),
                  loading: () => _buildLoadingCard(),
                  error: (error, stack) => _buildErrorCard(error.toString()),
                ),
                const SizedBox(height: 16),

                // InBody 스캔 섹션
                _buildInBodyScanSection(),
                const SizedBox(height: 16),

                // 진행 차트
                compositionsAsync.when(
                  data: (compositions) => compositions.length > 1
                      ? _buildProgressChart(compositions)
                      : _buildNoChartDataCard(),
                  loading: () => _buildLoadingCard(),
                  error: (error, stack) => _buildErrorCard(error.toString()),
                ),
                const SizedBox(height: 16),

                // 통계 개요
                statsAsync.when(
                  data: (stats) => _buildStatsOverview(stats),
                  loading: () => _buildLoadingCard(),
                  error: (error, stack) => _buildErrorCard(error.toString()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // 현재 나의 신체 탭
  Widget _buildCurrentBodyTab() {
    return Consumer(
      builder: (context, ref, child) {
        final profileAsync = ref.watch(userBodyProfileProvider);
        final latestCompositionAsync = ref.watch(latestBodyCompositionProvider);

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(userBodyProfileProvider);
            ref.invalidate(latestBodyCompositionProvider);
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // 사용자 프로필
                profileAsync.when(
                  data: (profile) => profile != null
                      ? _buildUserProfileCard(profile)
                      : _buildCreateProfileCard(),
                  loading: () => _buildLoadingCard(),
                  error: (error, stack) => _buildErrorCard(error.toString()),
                ),
                const SizedBox(height: 16),

                // 목표 진행률
                latestCompositionAsync.when(
                  data: (composition) => composition != null
                      ? _buildGoalProgressCard(composition)
                      : _buildNoGoalCard(),
                  loading: () => _buildLoadingCard(),
                  error: (error, stack) => _buildErrorCard(error.toString()),
                ),
                const SizedBox(height: 16),

                // 신체 지표
                _buildBodyIndicatorsCard(),
              ],
            ),
          ),
        );
      },
    );
  }

  // 운동루틴 탭
  Widget _buildWorkoutRoutineTab() {
    return Consumer(
      builder: (context, ref, child) {
        final profileAsync = ref.watch(userBodyProfileProvider);

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // 오늘의 추천 운동
              _buildTodayWorkoutCard(),
              const SizedBox(height: 16),

              // 운동 루틴 추천
              profileAsync.when(
                data: (profile) => profile != null
                    ? _buildWorkoutRoutineRecommendations(profile)
                    : _buildSetupProfileCard(),
                loading: () => _buildLoadingCard(),
                error: (error, stack) => _buildErrorCard(error.toString()),
              ),
              const SizedBox(height: 16),

              // 운동 기록
              _buildWorkoutHistoryCard(),
            ],
          ),
        );
      },
    );
  }

  // 최근 측정 결과 카드
  Widget _buildLatestMeasurementCard(BodyComposition composition) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '최근 측정 결과',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                if (composition.isFromInBodyScan)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.scanner, color: Colors.blue, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          'InBody',
                          style: TextStyle(
                            color: Colors.blue,
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
              children: [
                Expanded(
                  child: _buildStatItem(
                    '체중',
                    composition.weight.toStringAsFixed(1),
                    'kg',
                    Icons.monitor_weight,
                    Colors.blue,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    'BMI',
                    composition.bmi.toStringAsFixed(1),
                    '',
                    Icons.straighten,
                    _getBMIColor(composition.bmi),
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
                    composition.bodyFatPercentage.toStringAsFixed(1),
                    '%',
                    Icons.pie_chart,
                    Colors.orange,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    '근육량',
                    composition.muscleMass.toStringAsFixed(1),
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

  // InBody 스캔 섹션
  Widget _buildInBodyScanSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'InBody 결과지 스캔',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.auto_awesome, color: Colors.green, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        'AI OCR',
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
              children: [
                Expanded(
                  child: _buildScanOption(
                    '갤러리에서 선택',
                    '저장된 결과지 이미지 선택',
                    Icons.photo_library,
                    Colors.blue,
                    () => _selectInBodyImage(ImageSource.gallery),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildScanOption(
                    '카메라로 촬영',
                    '결과지를 직접 촬영',
                    Icons.camera_alt,
                    Colors.green,
                    () => _selectInBodyImage(ImageSource.camera),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Mock 데이터 테스트 버튼
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber, width: 1),
              ),
              child: Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: Colors.amber[700], size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '테스트용 Mock 데이터로 시험해보기',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.amber[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _processMockInBodyScan,
                    child: Text('시험', style: TextStyle(color: Colors.amber[700])),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 진행 차트
  Widget _buildProgressChart(List<BodyComposition> compositions) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '체성분 변화 추이',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() < 0 || value.toInt() >= compositions.length) {
                            return const Text('');
                          }
                          final composition = compositions[value.toInt()];
                          return Text(
                            '${composition.measurementDate.month}/${composition.measurementDate.day}',
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${value.toInt()}',
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: compositions.asMap().entries.map((e) =>
                        FlSpot(e.key.toDouble(), e.value.weight)
                      ).toList(),
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 2,
                      dotData: const FlDotData(show: true),
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

  // 공통 위젯들
  Widget _buildStatItem(String title, String value, String unit, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(title, style: Theme.of(context).textTheme.bodySmall),
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
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: color),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScanOption(String title, String description, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // 상태별 카드들
  Widget _buildNoDataCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Icon(
              Icons.analytics_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              '체성분 데이터가 없습니다',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '첫 번째 측정을 추가해보세요',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              '데이터를 불러오는 중...',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorCard(String error) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              '데이터를 불러올 수 없습니다',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // 헬퍼 메소드들
  Color _getBMIColor(double bmi) {
    if (bmi < 18.5) return Colors.blue;
    if (bmi < 23.0) return Colors.green;
    if (bmi < 25.0) return Colors.orange;
    return Colors.red;
  }

  // 임시 구현 - 실제로는 더 상세하게 구현 필요
  Widget _buildNoChartDataCard() => _buildNoDataCard();
  Widget _buildStatsOverview(BodyCompositionStats stats) => _buildNoDataCard();
  Widget _buildUserProfileCard(UserBodyProfile profile) => _buildNoDataCard();
  Widget _buildCreateProfileCard() => _buildNoDataCard();
  Widget _buildGoalProgressCard(BodyComposition composition) => _buildNoDataCard();
  Widget _buildNoGoalCard() => _buildNoDataCard();
  Widget _buildBodyIndicatorsCard() => _buildNoDataCard();
  Widget _buildTodayWorkoutCard() => _buildNoDataCard();
  Widget _buildWorkoutRoutineRecommendations(UserBodyProfile profile) => _buildNoDataCard();
  Widget _buildSetupProfileCard() => _buildNoDataCard();
  Widget _buildWorkoutHistoryCard() => _buildNoDataCard();

  // 액션 메소드들
  Future<void> _selectInBodyImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);

      if (image != null) {
        if (!mounted) return;
        _showProcessingDialog();

        final profile = await ref.read(userBodyProfileProvider.future);
        final height = profile?.height ?? 170.0;

        final bodyManager = ref.read(bodyCompositionManagerProvider.notifier);
        final result = await bodyManager.processInBodyScan(File(image.path), height);

        if (!mounted) return;
        Navigator.of(context).pop();

        if (result != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('InBody 결과가 성공적으로 분석되었습니다!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('InBody 분석에 실패했습니다. 다시 시도해주세요.')),
          );
        }
      }
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('오류가 발생했습니다: $e')),
      );
    }
  }

  Future<void> _processMockInBodyScan() async {
    try {
      if (!mounted) return;
      _showProcessingDialog();

      final profile = await ref.read(userBodyProfileProvider.future);
      final height = profile?.height ?? 170.0;

      final bodyManager = ref.read(bodyCompositionManagerProvider.notifier);
      final result = await bodyManager.processMockInBodyScan(height);

      if (!mounted) return;
      Navigator.of(context).pop();

      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mock InBody 데이터가 추가되었습니다!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mock 데이터 생성에 실패했습니다.')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('오류가 발생했습니다: $e')),
      );
    }
  }

  void _showProcessingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              'InBody 결과를 분석하는 중...',
              style: Theme.of(context).textTheme.bodyMedium,
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
        title: const Text('체성분 측정 추가'),
        content: const Text('어떤 방법으로 체성분 데이터를 추가하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _selectInBodyImage(ImageSource.gallery);
            },
            child: const Text('InBody 스캔'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _processMockInBodyScan();
            },
            child: const Text('Mock 데이터'),
          ),
        ],
      ),
    );
  }
}