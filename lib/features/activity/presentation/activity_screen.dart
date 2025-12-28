import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';
import '../providers/activity_providers.dart';
import '../../../features/food/providers/food_providers.dart';

class ActivityScreen extends ConsumerWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('SignCare',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {}, // TODO: Profile
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Greetings
            _buildHeader(context),
            const SizedBox(height: 24),

            // 2. Diet Dashboard (Main Focus)
            _buildDietSection(context, ref),
            const SizedBox(height: 24),

            // 3. AI Camera Action
            _buildAICameraButton(context),
            const SizedBox(height: 32),

            // 4. Activity Section (Secondary)
            _buildActivitySection(context, ref),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '오늘도 건강하게! 🌱',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          '나의 건강 대시보드',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ],
    );
  }

  Widget _buildDietSection(BuildContext context, WidgetRef ref) {
    final todayNutrition = ref.watch(todayNutritionProvider);
    final nutritionProgress = ref.watch(nutritionProgressProvider);
    final dailyIntake = ref.watch(dailyNutrientIntakeProvider);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('오늘의 식단',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () => context.go(AppRoutes.food),
              child: const Text('상세보기'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Card(
          elevation: 0,
          color: Theme.of(context)
              .colorScheme
              .primary
              .withOpacity(0.03), // Very subtle tint
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.1)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: todayNutrition.when(
              data: (nutrition) {
                final totalCalories = dailyIntake['calories']?.round() ?? 0;
                final calorieGoal = nutrition?.calorieGoal.round() ?? 2000;
                final progress = nutritionProgress['calories'] ?? 0.0;

                return Column(
                  children: [
                    // Main Calories Circle
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Stack(
                            children: [
                              SizedBox.expand(
                                child: CircularProgressIndicator(
                                  value: progress.clamp(0.0, 1.0),
                                  strokeWidth: 10,
                                  strokeCap: StrokeCap.round,
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainerHighest,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    progress > 1.0
                                        ? Colors.orange
                                        : Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${(progress * 100).toInt()}%',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: progress > 1.0
                                            ? Colors.orange
                                            : Theme.of(context)
                                                .colorScheme
                                                .primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 32),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('섭취 칼로리',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary)),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '$totalCalories',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        height: 1.0,
                                      ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 6, left: 4),
                                  child: Text(
                                    '/ $calorieGoal kcal',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 16),

                    // Macros Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildMacroItem(
                            context,
                            '탄수화물',
                            dailyIntake['carbs'] ?? 0,
                            nutrition?.carbsGoal ?? 250,
                            Colors.orange),
                        _buildMacroItem(
                            context,
                            '단백질',
                            dailyIntake['protein'] ?? 0,
                            nutrition?.proteinGoal ?? 60,
                            Colors.blue),
                        _buildMacroItem(context, '지방', dailyIntake['fat'] ?? 0,
                            nutrition?.fatGoal ?? 50, Colors.green),
                      ],
                    ),
                  ],
                );
              },
              loading: () => const Center(
                  child: Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator())),
              error: (e, _) => const Text('데이터를 불러올 수 없습니다'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMacroItem(BuildContext context, String label, double current,
      double goal, Color color) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          '${current.round()}g',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: color),
        ),
        Text(
          '/${goal.round()}g',
          style: TextStyle(
              fontSize: 12, color: Theme.of(context).colorScheme.outline),
        ),
      ],
    );
  }

  Widget _buildAICameraButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            const Color(0xFF3D8C7C), // Darker teal
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.go(AppRoutes.food),
          borderRadius: BorderRadius.circular(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.camera_alt, color: Colors.white, size: 28),
              const SizedBox(width: 12),
              const Text(
                'AI 음식 촬영하기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivitySection(BuildContext context, WidgetRef ref) {
    final todayActivitySummary = ref.watch(todayActivitySummaryProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('활동 요약',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        todayActivitySummary.when(
          data: (summary) {
            return Row(
              children: [
                Expanded(
                  child: _buildActivityCard(
                    context,
                    Icons.directions_walk,
                    '걸음 수',
                    '${summary['steps']?.toInt() ?? 0}',
                    '걸음',
                    Colors.indigoAccent,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActivityCard(
                    context,
                    Icons.local_fire_department,
                    '소모 칼로리',
                    '${summary['calories']?.toInt() ?? 0}',
                    'kcal',
                    Colors.deepOrangeAccent,
                  ),
                ),
              ],
            );
          },
          loading: () => const SizedBox(
              height: 100, child: Center(child: CircularProgressIndicator())),
          error: (e, _) => const Text('활동 데이터 오류'),
        ),
      ],
    );
  }

  Widget _buildActivityCard(BuildContext context, IconData icon, String title,
      String value, String unit, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest
            .withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(height: 12),
          Text(title,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 13)),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: ' $unit',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
