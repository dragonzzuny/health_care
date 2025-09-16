import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' hide Column;
import '../core/database/app_database.dart';
import '../shared/providers/database_providers.dart';
import '../core/mock/mock_food_data.dart';

class DatabaseDebugScreen extends ConsumerWidget {
  const DatabaseDebugScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('데이터베이스 확인'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDatabaseStatsSection(ref),
            const SizedBox(height: 20),
            _buildUserDataSection(ref),
            const SizedBox(height: 20),
            _buildFoodEntriesSection(ref),
            const SizedBox(height: 20),
            _buildActivityDataSection(ref),
          ],
        ),
      ),
    );
  }

  Widget _buildDatabaseStatsSection(WidgetRef ref) {
    final dbStats = ref.watch(databaseStatsProvider);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '📊 데이터베이스 통계',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            dbStats.when(
              data: (stats) => Column(
                children: stats.entries.map((entry) => 
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${entry.key}:'),
                        Text('${entry.value}개', style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ).toList(),
              ),
              loading: () => const CircularProgressIndicator(),
              error: (e, _) => Text('오류: $e'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserDataSection(WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '👤 사용자 정보',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            FutureBuilder<UserPreference?>(
              future: _getUserPreference(ref),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                
                if (snapshot.hasError) {
                  return Text('오류: ${snapshot.error}');
                }
                
                final user = snapshot.data;
                if (user == null) {
                  return const Text('사용자 데이터가 없습니다');
                }
                
                return Column(
                  children: [
                    _buildDataRow('사용자 ID', user.userId),
                    _buildDataRow('목표', user.goal),
                    _buildDataRow('활동 수준', user.activityLevel),
                    _buildDataRow('일일 칼로리 목표', '${user.dailyCalorieGoal.toStringAsFixed(0)} kcal'),
                    _buildDataRow('단백질 목표', '${user.dailyProteinGoal.toStringAsFixed(0)} g'),
                    _buildDataRow('키', '${user.height?.toStringAsFixed(0) ?? "미설정"} cm'),
                    _buildDataRow('몸무게', '${user.weight?.toStringAsFixed(1) ?? "미설정"} kg'),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodEntriesSection(WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🍽️ 최근 식사 기록',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _getRecentFoodEntries(ref),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                
                if (snapshot.hasError) {
                  return Text('오류: ${snapshot.error}');
                }
                
                final entries = snapshot.data ?? [];
                if (entries.isEmpty) {
                  return const Text('식사 기록이 없습니다');
                }
                
                return Column(
                  children: entries.take(5).map((entry) => 
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text('${entry['meal_type'] ?? "미정"} - ${entry['food_name'] ?? "음식"}'),
                          ),
                          Expanded(
                            child: Text('${entry['portion_grams']?.toStringAsFixed(0) ?? "0"}g'),
                          ),
                          Expanded(
                            child: Text('${entry['timestamp']}'.split(' ')[0]),
                          ),
                        ],
                      ),
                    )
                  ).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityDataSection(WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🏃 최근 활동 기록',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _getRecentActivities(ref),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                
                if (snapshot.hasError) {
                  return Text('오류: ${snapshot.error}');
                }
                
                final activities = snapshot.data ?? [];
                if (activities.isEmpty) {
                  return const Text('활동 기록이 없습니다');
                }
                
                return Column(
                  children: activities.take(5).map((activity) => 
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text('${activity['date']}'.split(' ')[0]),
                          ),
                          Expanded(
                            child: Text('${activity['steps'] ?? 0} 걸음'),
                          ),
                          Expanded(
                            child: Text('${activity['calories_burned'] ?? 0} kcal'),
                          ),
                        ],
                      ),
                    )
                  ).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Future<UserPreference?> _getUserPreference(WidgetRef ref) async {
    final db = ref.read(appDatabaseProvider);
    try {
      return await (db.select(db.userPreferences)
            ..where((up) => up.userId.equals(MockFoodData.userId)))
          .getSingleOrNull();
    } catch (e) {
      developer.log('사용자 데이터 조회 오류: $e');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> _getRecentFoodEntries(WidgetRef ref) async {
    final db = ref.read(appDatabaseProvider);
    try {
      final result = await db.customSelect('''
        SELECT fe.meal_type, fe.portion_grams, fe.timestamp, f.name_ko as food_name
        FROM food_entries fe
        JOIN foods f ON fe.food_id = f.id
        WHERE fe.user_id = ?
        ORDER BY fe.timestamp DESC
        LIMIT 10
      ''', variables: [Variable.withString(MockFoodData.userId)]).get();
      
      return result.map((row) => row.data).toList();
    } catch (e) {
      developer.log('식사 기록 조회 오류: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> _getRecentActivities(WidgetRef ref) async {
    final db = ref.read(appDatabaseProvider);
    try {
      final result = await db.customSelect('''
        SELECT date, steps, calories_burned, active_minutes
        FROM daily_activities
        WHERE user_id = ?
        ORDER BY date DESC
        LIMIT 7
      ''', variables: [Variable.withString(MockFoodData.userId)]).get();
      
      return result.map((row) => row.data).toList();
    } catch (e) {
      developer.log('활동 기록 조회 오류: $e');
      return [];
    }
  }
}