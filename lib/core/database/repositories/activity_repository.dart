import 'package:drift/drift.dart';
import '../app_database.dart';

class ActivityRepository {
  final AppDatabase _db;

  ActivityRepository(this._db);

  // 일일 활동 데이터
  
  /// 특정 날짜의 활동 데이터 조회
  Future<DailyActivity?> getDailyActivity(String userId, DateTime date) async {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    
    return await (_db.select(_db.dailyActivities)
          ..where((da) => 
              da.userId.equals(userId) & 
              da.date.equals(normalizedDate)))
        .getSingleOrNull();
  }

  /// 최근 7일 활동 데이터 조회
  Future<List<DailyActivity>> getWeeklyActivities(String userId) async {
    final now = DateTime.now();
    final weekAgo = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 6));
    
    return await (_db.select(_db.dailyActivities)
          ..where((da) => 
              da.userId.equals(userId) & 
              da.date.isBiggerOrEqualValue(weekAgo))
          ..orderBy([(da) => OrderingTerm.desc(da.date)]))
        .get();
  }

  /// 월간 활동 데이터 조회
  Future<List<DailyActivity>> getMonthlyActivities(String userId, DateTime month) async {
    final startOfMonth = DateTime(month.year, month.month, 1);
    final endOfMonth = DateTime(month.year, month.month + 1, 1).subtract(const Duration(days: 1));
    
    return await (_db.select(_db.dailyActivities)
          ..where((da) => 
              da.userId.equals(userId) & 
              da.date.isBiggerOrEqualValue(startOfMonth) &
              da.date.isSmallerOrEqualValue(endOfMonth))
          ..orderBy([(da) => OrderingTerm.desc(da.date)]))
        .get();
  }

  /// 일일 활동 데이터 생성/업데이트
  Future<void> upsertDailyActivity(DailyActivitiesCompanion activity) async {
    await _db.into(_db.dailyActivities).insertOnConflictUpdate(activity);
  }

  /// 일일 활동 통계 요약
  Future<Map<String, double>> getDailyActivitySummary(String userId, DateTime date) async {
    final activity = await getDailyActivity(userId, date);
    
    if (activity == null) {
      return {
        'steps': 0.0,
        'calories': 0.0,
        'activeMinutes': 0.0,
        'distance': 0.0,
      };
    }

    return {
      'steps': activity.steps.toDouble(),
      'calories': activity.caloriesBurned.toDouble(),
      'activeMinutes': activity.activeMinutes.toDouble(),
      'distance': (activity.distanceMeters / 1000).toDouble(), // km
    };
  }

  // 운동 세션

  /// 운동 세션 생성
  Future<int> createWorkoutSession(WorkoutSessionsCompanion session) async {
    return await _db.into(_db.workoutSessions).insert(session);
  }

  /// 특정 날짜의 운동 세션 조회
  Future<List<WorkoutSession>> getDailyWorkouts(String userId, DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    
    return await (_db.select(_db.workoutSessions)
          ..where((ws) => 
              ws.userId.equals(userId) & 
              ws.startTime.isBiggerOrEqualValue(startOfDay) &
              ws.startTime.isSmallerThanValue(endOfDay))
          ..orderBy([(ws) => OrderingTerm.desc(ws.startTime)]))
        .get();
  }

  /// 최근 운동 세션 조회 (제한 개수)
  Future<List<WorkoutSession>> getRecentWorkouts(String userId, {int limit = 10}) async {
    return await (_db.select(_db.workoutSessions)
          ..where((ws) => ws.userId.equals(userId))
          ..orderBy([(ws) => OrderingTerm.desc(ws.startTime)])
          ..limit(limit))
        .get();
  }

  /// 운동 세션 업데이트
  Future<void> updateWorkoutSession(int sessionId, WorkoutSessionsCompanion updates) async {
    await (_db.update(_db.workoutSessions)
          ..where((ws) => ws.id.equals(sessionId)))
        .write(updates);
  }

  /// 운동 세션 삭제
  Future<void> deleteWorkoutSession(int sessionId) async {
    await (_db.delete(_db.workoutSessions)
          ..where((ws) => ws.id.equals(sessionId)))
        .go();
  }

  // 활동 목표

  /// 사용자의 활동 목표 조회
  Future<ActivityGoal?> getActivityGoals(String userId) async {
    return await (_db.select(_db.activityGoals)
          ..where((ag) => ag.userId.equals(userId)))
        .getSingleOrNull();
  }

  /// 활동 목표 생성/업데이트
  Future<void> upsertActivityGoals(ActivityGoalsCompanion goals) async {
    await _db.into(_db.activityGoals).insertOnConflictUpdate(goals);
  }

  /// 목표 달성률 계산
  Future<Map<String, double>> getGoalProgress(String userId, DateTime date) async {
    final goals = await getActivityGoals(userId);
    final activity = await getDailyActivity(userId, date);
    
    if (goals == null || activity == null) {
      return {
        'steps': 0.0,
        'calories': 0.0,
        'activeMinutes': 0.0,
        'distance': 0.0,
      };
    }

    return {
      'steps': goals.stepsGoal > 0 ? (activity.steps / goals.stepsGoal) : 0.0,
      'calories': goals.caloriesBurnedGoal > 0 ? (activity.caloriesBurned / goals.caloriesBurnedGoal) : 0.0,
      'activeMinutes': goals.activeMinutesGoal > 0 ? (activity.activeMinutes / goals.activeMinutesGoal) : 0.0,
      'distance': goals.distanceGoal > 0 ? (activity.distanceMeters / goals.distanceGoal) : 0.0,
    };
  }

  // 체중 기록

  /// 체중 기록 생성
  Future<int> createWeightRecord(WeightRecordsCompanion record) async {
    return await _db.into(_db.weightRecords).insert(record);
  }

  /// 최근 체중 기록 조회
  Future<WeightRecord?> getLatestWeight(String userId) async {
    return await (_db.select(_db.weightRecords)
          ..where((wr) => wr.userId.equals(userId))
          ..orderBy([(wr) => OrderingTerm.desc(wr.date)])
          ..limit(1))
        .getSingleOrNull();
  }

  /// 체중 기록 히스토리 조회
  Future<List<WeightRecord>> getWeightHistory(String userId, {int? days}) async {
    var query = _db.select(_db.weightRecords)
      ..where((wr) => wr.userId.equals(userId))
      ..orderBy([(wr) => OrderingTerm.desc(wr.date)]);
    
    if (days != null) {
      final cutoffDate = DateTime.now().subtract(Duration(days: days));
      query = query..where((wr) => wr.date.isBiggerOrEqualValue(cutoffDate));
    }
    
    return await query.get();
  }

  /// 체중 기록 업데이트
  Future<void> updateWeightRecord(int recordId, WeightRecordsCompanion updates) async {
    await (_db.update(_db.weightRecords)
          ..where((wr) => wr.id.equals(recordId)))
        .write(updates);
  }

  /// 체중 기록 삭제
  Future<void> deleteWeightRecord(int recordId) async {
    await (_db.delete(_db.weightRecords)
          ..where((wr) => wr.id.equals(recordId)))
        .go();
  }

  // 통계 및 분석

  /// 주간 활동 통계
  Future<Map<String, dynamic>> getWeeklyStats(String userId) async {
    final activities = await getWeeklyActivities(userId);
    
    if (activities.isEmpty) {
      return {
        'totalSteps': 0,
        'totalCalories': 0,
        'totalActiveMinutes': 0,
        'averageSteps': 0.0,
        'averageCalories': 0.0,
        'daysActive': 0,
      };
    }

    final totalSteps = activities.fold(0, (sum, a) => sum + a.steps);
    final totalCalories = activities.fold(0, (sum, a) => sum + a.caloriesBurned);
    final totalActiveMinutes = activities.fold(0, (sum, a) => sum + a.activeMinutes);
    final daysActive = activities.where((a) => a.activeMinutes > 0).length;

    return {
      'totalSteps': totalSteps,
      'totalCalories': totalCalories,
      'totalActiveMinutes': totalActiveMinutes,
      'averageSteps': totalSteps / activities.length,
      'averageCalories': totalCalories / activities.length,
      'daysActive': daysActive,
    };
  }

  /// 운동 타입별 통계
  Future<Map<String, dynamic>> getWorkoutTypeStats(String userId, {int? days}) async {
    var query = _db.select(_db.workoutSessions)
      ..where((ws) => ws.userId.equals(userId));
    
    if (days != null) {
      final cutoffDate = DateTime.now().subtract(Duration(days: days));
      query = query..where((ws) => ws.startTime.isBiggerOrEqualValue(cutoffDate));
    }
    
    final workouts = await query.get();
    
    final typeStats = <String, Map<String, dynamic>>{};
    
    for (final workout in workouts) {
      if (!typeStats.containsKey(workout.type)) {
        typeStats[workout.type] = {
          'count': 0,
          'totalDuration': 0,
          'totalCalories': 0,
          'name': workout.name,
        };
      }
      
      typeStats[workout.type]!['count'] += 1;
      typeStats[workout.type]!['totalDuration'] += workout.duration;
      typeStats[workout.type]!['totalCalories'] += workout.caloriesBurned;
    }
    
    return typeStats;
  }
}