import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/vision/detector.dart';
// import '../../../core/vision/yolo_view_detector.dart'; // Temporarily disabled
import '../../../core/vision/mock_detector.dart';
import '../../food/services/nutrition_repository.dart';
import '../../../core/vision/detection.dart';
import 'dart:ui' as ui;
import 'dart:io';

import '../../../shared/providers/app_providers.dart';
import '../../../shared/services/api_service.dart';
import '../providers/food_providers.dart';
import '../../../core/database/app_database.dart';
import '../repositories/food_entry_repository.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:fl_chart/fl_chart.dart';

extension StringExt on String {
  String capitalize() =>
      length > 0 ? this[0].toUpperCase() + substring(1) : this;
}

class FoodScreen extends ConsumerStatefulWidget {
  const FoodScreen({super.key});

  @override
  ConsumerState<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends ConsumerState<FoodScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ImagePicker _picker = ImagePicker();
  final NutritionRepository _nutritionRepo = NutritionRepository();
  late VisionDetector _detector;
  bool _detectorReady = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _initializeDetector();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _detector.dispose();
    super.dispose();
  }

  Future<void> _initializeDetector() async {
    try {
      // _detector = YoloViewDetector(modelPath: 'yolo11n'); // Temporarily disabled
      _detector = MockDetector(); // Use mock detector for now
      await _detector.load();
    } catch (_) {
      _detector = MockDetector();
      await _detector.load();
    }
    if (mounted) setState(() => _detectorReady = _detector.isLoaded);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('식단 관리'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(icon: Icon(Icons.camera_alt), text: 'AI 인식'),
            Tab(icon: Icon(Icons.restaurant_menu), text: '식단 기록'),
            Tab(icon: Icon(Icons.analytics), text: '영양 분석'),
            Tab(icon: Icon(Icons.history), text: '히스토리'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAIRecognitionTab(),
          _buildTodayTab(),
          _buildAnalysisTab(),
          _buildHistoryTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _pickAndRecognize(ImageSource.camera);
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }

  Widget _buildAIRecognitionTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AI 인식 상태 카드
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        _detectorReady ? Icons.check_circle : Icons.schedule,
                        color: _detectorReady ? Colors.green : Colors.orange,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _detectorReady ? 'AI 모델 준비 완료' : 'AI 모델 로딩 중...',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: _detectorReady
                                        ? Colors.green
                                        : Colors.orange,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _detectorReady
                        ? '음식 사진을 촬영하거나 선택하여 영양 정보를 확인하세요'
                        : 'AI 모델을 불러오는 중입니다. 잠시만 기다려주세요',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 촬영 버튼들
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  icon: Icons.camera_alt,
                  label: '카메라로 촬영',
                  onPressed: _detectorReady
                      ? () => _pickAndRecognize(ImageSource.camera)
                      : null,
                  isPrimary: true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionButton(
                  icon: Icons.photo_library,
                  label: '갤러리에서 선택',
                  onPressed: _detectorReady
                      ? () => _pickAndRecognize(ImageSource.gallery)
                      : null,
                  isPrimary: false,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // 촬영 가이드
          _buildPhotographyGuide(),
          const SizedBox(height: 24),

          // 최근 인식 결과
          _buildRecentRecognitions(),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback? onPressed,
    required bool isPrimary,
  }) {
    return SizedBox(
      height: 56,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 24),
        label: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surfaceVariant,
          foregroundColor: isPrimary
              ? Colors.white
              : Theme.of(context).colorScheme.onSurfaceVariant,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotographyGuide() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  color: Theme.of(context).colorScheme.primary,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  '더 나은 인식을 위한 팁',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildGuideTip(
              Icons.wb_sunny_outlined,
              '충분한 조명',
              '자연광이나 밝은 조명 아래에서 촬영하세요',
            ),
            const SizedBox(height: 12),
            _buildGuideTip(
              Icons.center_focus_strong,
              '음식에 집중',
              '음식이 화면의 중앙에 크게 보이도록 촬영하세요',
            ),
            const SizedBox(height: 12),
            _buildGuideTip(
              Icons.straighten,
              '적당한 거리',
              '너무 가깝거나 멀지 않게, 20-30cm 거리를 유지하세요',
            ),
            const SizedBox(height: 12),
            _buildGuideTip(
              Icons.cleaning_services,
              '깔끔한 배경',
              '복잡한 배경보다는 단순한 배경이 좋습니다',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuideTip(IconData icon, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 2),
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

  Widget _buildRecentRecognitions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.history,
              color: Theme.of(context).colorScheme.primary,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              '최근 인식 결과',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // 최근 인식 결과가 없는 경우
        Card(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Icon(
                  Icons.camera_alt_outlined,
                  size: 48,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurfaceVariant
                      .withOpacity(0.5),
                ),
                const SizedBox(height: 12),
                Text(
                  '아직 인식한 음식이 없습니다',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  '첫 음식을 촬영해보세요!',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant
                            .withOpacity(0.7),
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTodayTab() {
    return Consumer(
      builder: (context, ref, child) {
        final todayMeals = ref.watch(todayMealsProvider);
        final nutritionProgress = ref.watch(nutritionProgressProvider);
        
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Daily Summary Card
              _buildDailySummaryCard(ref),
              const SizedBox(height: 16),

              // Meals by Type
              todayMeals.when(
                data: (meals) {
                  final mealsByType = <String, List<FoodEntryWithFood>>{};
                  
                  // 식사 타입별로 그룹핑
                  for (final meal in meals) {
                    final type = meal.entry.mealType;
                    mealsByType[type] = mealsByType[type] ?? [];
                    mealsByType[type]!.add(meal);
                  }
                  
                  return Column(
                    children: [
                      _buildMealSectionFromDB('아침', Icons.wb_sunny, mealsByType['breakfast'] ?? []),
                      const SizedBox(height: 16),
                      _buildMealSectionFromDB('점심', Icons.wb_sunny_outlined, mealsByType['lunch'] ?? []),
                      const SizedBox(height: 16),
                      _buildMealSectionFromDB('저녁', Icons.nightlight_round, mealsByType['dinner'] ?? []),
                      const SizedBox(height: 16),
                      _buildMealSectionFromDB('간식', Icons.cookie, mealsByType['snack'] ?? []),
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Column(
                    children: [
                      const Icon(Icons.error, size: 48, color: Colors.red),
                      const SizedBox(height: 8),
                      Text('식사 기록을 불러올 수 없습니다\n$error'),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Quick Add Buttons
              _buildQuickAddSection(ref),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDailySummaryCard(WidgetRef ref) {
    final todayNutrition = ref.watch(todayNutritionProvider);
    final nutritionProgress = ref.watch(nutritionProgressProvider);
    final dailyIntake = ref.watch(dailyNutrientIntakeProvider);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: todayNutrition.when(
          data: (nutrition) {
            final totalCalories = dailyIntake['calories']?.round() ?? 0;
            final calorieGoal = nutrition?.calorieGoal?.round() ?? 1800;
            final progress = nutritionProgress['calories'] ?? 0.0;
            
            return Column(
              children: [
                Text(
                  '오늘의 칼로리',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),

                // Circular Progress and Text in a Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // CircularProgressIndicator on the left
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        value: progress.clamp(0.0, 1.0),
                        strokeWidth: 8,
                        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          progress > 1.0 
                            ? Colors.orange
                            : Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),

                    // Text on the right
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$totalCalories',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: progress > 1.0 
                                  ? Colors.orange
                                  : Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        Text(
                          '/ $calorieGoal kcal',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          '${(progress * 100).round()}% 달성',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: progress > 1.0 ? Colors.orange : Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 25),

                // Macros
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildMacroInfoFromData(
                      '탄수화물', 
                      dailyIntake['carbs'] ?? 0.0,
                      nutrition?.carbsGoal ?? 250.0,
                      Colors.orange
                    ),
                    _buildMacroInfoFromData(
                      '단백질', 
                      dailyIntake['protein'] ?? 0.0,
                      nutrition?.proteinGoal ?? 50.0,
                      Colors.blue
                    ),
                    _buildMacroInfoFromData(
                      '지방', 
                      dailyIntake['fat'] ?? 0.0,
                      nutrition?.fatGoal ?? 65.0,
                      Colors.green
                    ),
                  ],
                ),
              ],
            );
          },
          loading: () => const Column(
            children: [
              Text('오늘의 영양 정보'),
              SizedBox(height: 20),
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('데이터를 불러오는 중...'),
            ],
          ),
          error: (error, stack) => Column(
            children: [
              const Icon(Icons.error, color: Colors.red),
              const SizedBox(height: 8),
              Text('영양 정보를 불러올 수 없습니다'),
              Text('$error', style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMacroInfoFromData(String name, double actual, double goal, Color color) {
    final percentage = goal > 0 ? (actual / goal * 100).round() : 0;
    return Column(
      children: [
        Text(
          '${actual.round()}g',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          name,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          '$percentage%',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: percentage > 100 ? Colors.orange : Colors.green,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }

  Widget _buildMacroInfo(
      String name, String amount, String percentage, Color color) {
    return Column(
      children: [
        Text(
          name,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
        ),
        Text(
          percentage,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: color,
              ),
        ),
      ],
    );
  }

  Widget _buildMealSection(
      String mealName, IconData icon, List<Map<String, dynamic>> foods) {
    final totalCalories =
        foods.fold<int>(0, (sum, food) => sum + (food['calories'] as int));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  mealName,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                Text(
                  '${totalCalories} kcal',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (foods.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .surfaceVariant
                      .withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color:
                        Theme.of(context).colorScheme.outline.withOpacity(0.3),
                    style: BorderStyle.solid,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      size: 32,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '음식을 추가해보세요',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              )
            else
              ...foods
                  .map((food) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceVariant,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.restaurant,
                                size: 20,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    food['name'] as String,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  Text(
                                    food['time'] as String,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '${food['calories']} kcal',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalysisTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Weekly Chart
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '주간 칼로리 추이',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 200,
                    child: Center(
                      child: Text(
                        '차트 영역\n(실제 구현 시 charts_flutter 패키지 사용)',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Nutrition Analysis
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '영양소 분석',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  _buildNutritionBar('탄수화물', 0.6, Colors.orange),
                  const SizedBox(height: 12),
                  _buildNutritionBar('단백질', 0.8, Colors.blue),
                  const SizedBox(height: 12),
                  _buildNutritionBar('지방', 0.4, Colors.green),
                  const SizedBox(height: 12),
                  _buildNutritionBar('식이섬유', 0.3, Colors.purple),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Recommendations
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AI 추천',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  _buildRecommendationItem(
                    '단백질 섭취량을 늘려보세요',
                    '현재 단백질 섭취량이 권장량보다 부족합니다.',
                    Icons.fitness_center,
                    Colors.blue,
                  ),
                  const SizedBox(height: 12),
                  _buildRecommendationItem(
                    '식이섬유가 풍부한 음식을 드세요',
                    '야채와 과일 섭취를 늘리면 좋겠어요.',
                    Icons.eco,
                    Colors.green,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionBar(String name, double progress, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Text(
              '${(progress * 100).toInt()}%',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: color.withOpacity(0.2),
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ],
    );
  }

  Widget _buildRecommendationItem(
      String title, String description, IconData icon, Color color) {
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
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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

  Widget _buildHistoryTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 7,
      itemBuilder: (context, index) {
        final dates = ['오늘', '어제', '2일 전', '3일 전', '4일 전', '5일 전', '6일 전'];
        final calories = [760, 1180, 1050, 1320, 980, 1150, 1200];

        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.1),
              child: Icon(
                Icons.calendar_today,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
            ),
            title: Text(
              dates[index],
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            subtitle: Text('총 ${calories[index]} kcal'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Navigate to detailed day view
            },
          ),
        );
      },
    );
  }

  // YOLO 기반 인식 실행 및 결과 편집 시트 표시
  Future<void> _pickAndRecognize(ImageSource source) async {
    final XFile? picked =
        await _picker.pickImage(source: source, imageQuality: 85);
    if (picked == null) return;

    if (!_detectorReady) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('인식 엔진 준비 중입니다. 잠시 후 다시 시도하세요.')),
      );
      return;
    }

    final detections = await _detector.detect(File(picked.path));
    if (detections.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('음식을 감지하지 못했습니다. 조명/각도를 바꿔 다시 시도하세요.')),
      );
      return;
    }

    // 원본 이미지 크기 파악
    final bytes = await File(picked.path).readAsBytes();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    final imgW = frame.image.width.toDouble();
    final imgH = frame.image.height.toDouble();
    frame.image.dispose();
    codec.dispose();

    // 바운딩박스 면적 비율에 따른 초기 분량 추정
    final items = <RecognizedFoodItem>[];
    for (final d in detections) {
      final area = d.bbox.width * d.bbox.height;
      final ratio = area / (imgW * imgH + 1);
      int grams = ratio > 0.25 ? 300 : (ratio > 0.12 ? 200 : 120);

      final per100 = await _nutritionRepo.findPer100g(d.label) ??
          const NutritionPer100g(
              kcal: 0, carbs: 0, protein: 0, fat: 0, fiber: 0);

      items.add(
        RecognizedFoodItem(
          label: d.label,
          confidence: d.score,
          grams: grams,
          kcalPer100g: per100.kcal,
          carbsPer100g: per100.carbs,
          proteinPer100g: per100.protein,
          fatPer100g: per100.fat,
        ),
      );
    }

    if (!mounted) return;
    _showRecognitionEditSheet(items);
  }

  void _showRecognitionEditSheet(List<RecognizedFoodItem> items) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(builder: (context, setModalState) {
          double totalKcal = items.fold(0, (s, e) => s + e.calories);
          double totalCarbs = items.fold(0, (s, e) => s + e.carbs);
          double totalProtein = items.fold(0, (s, e) => s + e.protein);
          double totalFat = items.fold(0, (s, e) => s + e.fat);

          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 헤더
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.psychology,
                            color: Theme.of(context).colorScheme.primary,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'AI 인식 결과',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                '${items.length}개 음식이 인식되었습니다',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close),
                          style: IconButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.surfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // 인식된 음식 리스트
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: _buildFoodRecognitionCard(
                              item,
                              index,
                              (newItem) {
                                setModalState(() {
                                  items[index] = newItem;
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ),

                    // 영양 요약 카드
                    _buildNutritionSummaryCard(
                        totalKcal, totalCarbs, totalProtein, totalFat),
                    const SizedBox(height: 16),

                    // 액션 버튼들
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.edit),
                            label: const Text('수정'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          '식단이 성공적으로 저장되었습니다!',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                  backgroundColor: Colors.green,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              );
                              // TODO: 서버 저장(/food/entries) 및 챗봇 컨텍스트 푸시
                            },
                            icon: const Icon(Icons.save),
                            label: const Text('저장하기'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  Widget _buildFoodRecognitionCard(
    RecognizedFoodItem item,
    int index,
    Function(RecognizedFoodItem) onChanged,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 음식 정보 헤더
            Row(
              children: [
                // 음식 아이콘
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        Theme.of(context).colorScheme.primary.withOpacity(0.2),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getFoodIcon(item.label),
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.label.capitalize(),
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 4),
                      // 신뢰도 표시
                      Row(
                        children: [
                          Icon(
                            Icons.psychology,
                            size: 14,
                            color: _getConfidenceColor(item.confidence),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '신뢰도 ${(item.confidence * 100).toStringAsFixed(0)}%',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: _getConfidenceColor(item.confidence),
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // 칼로리 표시
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${item.calories.toStringAsFixed(0)}',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                    ),
                    Text(
                      'kcal',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 포션 조절 슬라이더
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surfaceVariant
                    .withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '분량 조절',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '${item.grams}g',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 6,
                      thumbShape:
                          const RoundSliderThumbShape(enabledThumbRadius: 10),
                    ),
                    child: Slider(
                      value: item.grams.toDouble(),
                      min: 40,
                      max: 500,
                      divisions: 46,
                      label: '${item.grams}g',
                      onChanged: (value) {
                        onChanged(item.copyWith(grams: value.round()));
                      },
                    ),
                  ),
                  // 포션 가이드
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildPortionGuide('소량', '40g'),
                      _buildPortionGuide('보통', '200g'),
                      _buildPortionGuide('많음', '500g'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // 영양소 정보
            _buildNutrientInfo(item),
          ],
        ),
      ),
    );
  }

  Widget _buildPortionGuide(String label, String weight) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        Text(
          weight,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }

  Widget _buildNutrientInfo(RecognizedFoodItem item) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '영양 성분',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildNutrientItem('탄수화물', item.carbs, Colors.orange),
              _buildNutrientItem('단백질', item.protein, Colors.blue),
              _buildNutrientItem('지방', item.fat, Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientItem(String name, double value, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 2),
          Text(
            '${value.toStringAsFixed(1)}g',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionSummaryCard(
      double kcal, double carbs, double protein, double fat) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.calculate,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '총 영양 정보',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    '${kcal.toStringAsFixed(0)} kcal',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildNutrientSummary('탄수화물', carbs, Colors.orange),
                _buildNutrientSummary('단백질', protein, Colors.blue),
                _buildNutrientSummary('지방', fat, Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutrientSummary(String name, double value, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 4),
          Text(
            '${value.toStringAsFixed(1)}g',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
          ),
        ],
      ),
    );
  }

  IconData _getFoodIcon(String foodLabel) {
    // 영어 라벨에 따른 아이콘 매핑
    final iconMap = {
      'rice': Icons.rice_bowl,
      'bread': Icons.breakfast_dining,
      'meat': Icons.kebab_dining,
      'vegetable': Icons.eco,
      'fruit': Icons.apple,
      'fish': Icons.set_meal,
      'soup': Icons.soup_kitchen,
    };
    
    // 한글 음식명에 따른 아이콘 매핑
    if (foodLabel.contains('밥') || foodLabel.contains('rice')) return Icons.rice_bowl;
    if (foodLabel.contains('고기') || foodLabel.contains('닭') || foodLabel.contains('beef')) return Icons.kebab_dining;
    if (foodLabel.contains('야채') || foodLabel.contains('브로콜리') || foodLabel.contains('상추')) return Icons.eco;
    if (foodLabel.contains('과일') || foodLabel.contains('사과') || foodLabel.contains('바나나')) return Icons.apple;
    if (foodLabel.contains('생선') || foodLabel.contains('연어') || foodLabel.contains('참치')) return Icons.set_meal;
    if (foodLabel.contains('찌개') || foodLabel.contains('스프') || foodLabel.contains('탕')) return Icons.soup_kitchen;

    // 기본값으로 restaurant 아이콘 사용
    return iconMap[foodLabel.toLowerCase()] ?? Icons.restaurant;
  }

  Color _getConfidenceColor(double confidence) {
    if (confidence >= 0.8) return Colors.green;
    if (confidence >= 0.6) return Colors.orange;
    return Colors.red;
  }

  // 데이터베이스 기반 식사 섹션
  Widget _buildMealSectionFromDB(String mealType, IconData icon, List<FoodEntryWithFood> meals) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  mealType,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                if (meals.isNotEmpty)
                  Text(
                    '${_calculateTotalCalories(meals).round()} kcal',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _showAddFoodDialog(mealType),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (meals.isEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    '아직 $mealType 기록이 없습니다',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              )
            else
              ...meals.map((meal) => _buildMealItem(meal)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildMealItem(FoodEntryWithFood meal) {
    final calories = _calculateMealCalories(meal);
    final time = "${meal.entry.timestamp.hour.toString().padLeft(2, '0')}:${meal.entry.timestamp.minute.toString().padLeft(2, '0')}";
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getFoodIcon(meal.food.nameKo),
              size: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.food.nameKo,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${meal.entry.portionGrams.round()}g • ${calories.round()} kcal • $time',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                if (meal.entry.notes != null && meal.entry.notes!.isNotEmpty)
                  Text(
                    meal.entry.notes!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, size: 20),
            onSelected: (value) {
              switch (value) {
                case 'edit':
                  _showEditMealDialog(meal);
                  break;
                case 'delete':
                  _deleteMeal(meal.entry.id);
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit, size: 16),
                    SizedBox(width: 8),
                    Text('수정'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, size: 16, color: Colors.red),
                    SizedBox(width: 8),
                    Text('삭제', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  double _calculateTotalCalories(List<FoodEntryWithFood> meals) {
    return meals.fold(0.0, (sum, meal) => sum + _calculateMealCalories(meal));
  }

  double _calculateMealCalories(FoodEntryWithFood meal) {
    return meal.entry.portionGrams * meal.food.kcalPer100g / 100;
  }

  // 빠른 추가 섹션
  Widget _buildQuickAddSection(WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '빠른 추가',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        
        // 즐겨찾는 포션
        Consumer(
          builder: (context, ref, child) {
            final favorites = ref.watch(myFavoritePortionsProvider);
            
            return favorites.when(
              data: (favoriteList) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (favoriteList.isNotEmpty) ...[
                    Text(
                      '즐겨찾는 음식',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: favoriteList.length,
                        itemBuilder: (context, index) {
                          final favorite = favoriteList[index];
                          return Container(
                            width: 120,
                            margin: const EdgeInsets.only(right: 12),
                            child: _buildQuickAddCard(
                              favorite.food.nameKo,
                              '${favorite.favoritePortion.portionGrams.round()}g',
                              () => _addFavoritePortion(favorite),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  
                  // 최근 음식
                  Text(
                    '최근 섭취한 음식',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Consumer(
                    builder: (context, ref, child) {
                      final recentFoods = ref.watch(recentFoodsProvider);
                      
                      return recentFoods.when(
                        data: (foods) => SizedBox(
                          height: 80,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: foods.length,
                            itemBuilder: (context, index) {
                              final food = foods[index];
                              return Container(
                                width: 120,
                                margin: const EdgeInsets.only(right: 12),
                                child: _buildQuickAddCard(
                                  food.nameKo,
                                  '100g 기준',
                                  () => _showAddPortionDialog(food, 'snack'),
                                ),
                              );
                            },
                          ),
                        ),
                        loading: () => const SizedBox(
                          height: 80,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        error: (_, __) => const SizedBox(height: 80),
                      );
                    },
                  ),
                ],
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => const SizedBox(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildQuickAddCard(String name, String portion, VoidCallback onTap) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getFoodIcon(name),
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
              const SizedBox(height: 4),
              Text(
                name,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                portion,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 음식 추가 다이얼로그
  void _showAddFoodDialog(String mealType) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(16),
        child: Consumer(
          builder: (context, ref, child) {
            return Column(
              children: [
                Text(
                  '$mealType 추가',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    hintText: '음식을 검색하세요',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (query) {
                    ref.read(foodSearchQueryProvider.notifier).state = query;
                  },
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Consumer(
                    builder: (context, ref, child) {
                      final searchResults = ref.watch(searchedFoodsProvider);
                      
                      return searchResults.when(
                        data: (foods) => ListView.builder(
                          itemCount: foods.length,
                          itemBuilder: (context, index) {
                            final food = foods[index];
                            return ListTile(
                              leading: Icon(_getFoodIcon(food.nameKo)),
                              title: Text(food.nameKo),
                              subtitle: Text('${food.kcalPer100g} kcal/100g'),
                              onTap: () {
                                Navigator.of(context).pop();
                                _showAddPortionDialog(food, mealType);
                              },
                            );
                          },
                        ),
                        loading: () => const Center(child: CircularProgressIndicator()),
                        error: (_, __) => const Center(
                          child: Text('검색 결과를 불러올 수 없습니다'),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showAddPortionDialog(Food food, String mealType) {
    double portion = 100.0;
    String? notes;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${food.nameKo} 추가'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '분량 (g)',
                hintText: '100',
              ),
              onChanged: (value) {
                portion = double.tryParse(value) ?? 100.0;
              },
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: '메모 (선택사항)',
                hintText: '예: 맛있게 먹었음',
              ),
              onChanged: (value) {
                notes = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          Consumer(
            builder: (context, ref, child) {
              return ElevatedButton(
                onPressed: () async {
                  try {
                    await ref.read(mealEntryProvider.notifier).addMealEntry(
                      foodId: food.id,
                      portionGrams: portion,
                      mealType: mealType,
                      notes: notes,
                    );
                    
                    if (mounted) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${food.nameKo}이(가) 추가되었습니다')),
                      );
                      
                      // 데이터 새로고침
                      ref.invalidate(todayMealsProvider);
                      ref.invalidate(todayNutritionProvider);
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('추가 실패: $e')),
                      );
                    }
                  }
                },
                child: const Text('추가'),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showEditMealDialog(FoodEntryWithFood meal) {
    double portion = meal.entry.portionGrams;
    String? notes = meal.entry.notes;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${meal.food.nameKo} 수정'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              controller: TextEditingController(text: portion.toString()),
              decoration: const InputDecoration(
                labelText: '분량 (g)',
              ),
              onChanged: (value) {
                portion = double.tryParse(value) ?? portion;
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: TextEditingController(text: notes ?? ''),
              decoration: const InputDecoration(
                labelText: '메모',
              ),
              onChanged: (value) {
                notes = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          Consumer(
            builder: (context, ref, child) {
              return ElevatedButton(
                onPressed: () async {
                  try {
                    await ref.read(mealEntryProvider.notifier).updateMealEntry(
                      entryId: meal.entry.id,
                      portionGrams: portion,
                      notes: notes,
                    );
                    
                    if (mounted) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('수정되었습니다')),
                      );
                      
                      ref.invalidate(todayMealsProvider);
                      ref.invalidate(todayNutritionProvider);
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('수정 실패: $e')),
                      );
                    }
                  }
                },
                child: const Text('수정'),
              );
            },
          ),
        ],
      ),
    );
  }

  void _deleteMeal(int entryId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('삭제 확인'),
        content: const Text('이 식사 기록을 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          Consumer(
            builder: (context, ref, child) {
              return TextButton(
                onPressed: () async {
                  try {
                    await ref.read(mealEntryProvider.notifier).deleteMealEntry(entryId);
                    
                    if (mounted) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('삭제되었습니다')),
                      );
                      
                      ref.invalidate(todayMealsProvider);
                      ref.invalidate(todayNutritionProvider);
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('삭제 실패: $e')),
                      );
                    }
                  }
                },
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('삭제'),
              );
            },
          ),
        ],
      ),
    );
  }

  void _addFavoritePortion(FavoritePortionWithFood favorite) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${favorite.food.nameKo} 추가'),
        content: Text('${favorite.favoritePortion.portionGrams.round()}g을 추가하시겠습니까?\n(${favorite.favoritePortion.nickname ?? '즐겨찾는 포션'})'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          Consumer(
            builder: (context, ref, child) {
              return ElevatedButton(
                onPressed: () async {
                  try {
                    await ref.read(mealEntryProvider.notifier).addMealEntry(
                      foodId: favorite.food.id,
                      portionGrams: favorite.favoritePortion.portionGrams,
                      mealType: 'snack', // 빠른 추가는 기본적으로 간식으로
                      notes: favorite.favoritePortion.nickname,
                    );
                    
                    if (mounted) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${favorite.food.nameKo}이(가) 추가되었습니다')),
                      );
                      
                      ref.invalidate(todayMealsProvider);
                      ref.invalidate(todayNutritionProvider);
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('추가 실패: $e')),
                      );
                    }
                  }
                },
                child: const Text('추가'),
              );
            },
          ),
        ],
      ),
    );
  }
}
