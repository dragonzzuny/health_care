import 'dart:developer' as developer;
import 'package:drift/drift.dart';
import '../database/app_database.dart';
import '../mock/mock_food_data.dart';
import '../mock/mock_activity_data.dart';

class DataInitializer {
  final AppDatabase _db;

  DataInitializer(this._db);

  /// 전체 Mock 데이터 초기화
  Future<void> initializeAllMockData() async {
    try {
      await _db.transaction(() async {
        // 1. 사용자 설정 추가
        await _initializeUserPreferences();

        // 2. 식단 데이터 추가
        await _initializeFoodEntries();

        // 3. 즐겨찾는 포션 추가
        await _initializeFavoritePortions();

        // 4. 사용자 음식 통계 추가
        await _initializeUserFoodStatistics();

        // 5. 활동 데이터 추가
        await _initializeActivityData();

        developer.log('✅ Mock 데이터 초기화가 완료되었습니다.');
      });
    } catch (e) {
      developer.log('❌ Mock 데이터 초기화 중 오류 발생: $e');
      rethrow;
    }
  }

  /// 사용자 설정 초기화
  Future<void> _initializeUserPreferences() async {
    final userData = MockFoodData.getUserPreferences();

    // 기존 데이터가 있는지 확인
    final existingUser = await (_db.select(_db.userPreferences)
          ..where((up) => up.userId.equals(userData['userId'])))
        .getSingleOrNull();

    if (existingUser == null) {
      await _db.into(_db.userPreferences).insert(
            UserPreferencesCompanion(
              userId: Value(userData['userId']),
              goal: Value(userData['goal']),
              activityLevel: Value(userData['activityLevel']),
              dailyCalorieGoal: Value(userData['dailyCalorieGoal']),
              dailyCarbsGoal: Value(userData['dailyCarbsGoal']),
              dailyProteinGoal: Value(userData['dailyProteinGoal']),
              dailyFatGoal: Value(userData['dailyFatGoal']),
              dailyFiberGoal: Value(userData['dailyFiberGoal']),
              height: Value(userData['height']),
              weight: Value(userData['weight']),
              gender: Value(userData['gender']),
            ),
          );
      developer.log('✅ 사용자 설정 데이터 추가 완료');
    }
  }

  /// 식사 기록 초기화
  Future<void> _initializeFoodEntries() async {
    final mealData = MockFoodData.getWeeklyMealData();

    // 기존 데이터 개수 확인
    final existingCount = await _db.customSelect(
        'SELECT COUNT(*) as count FROM food_entries WHERE user_id = ?',
        variables: [Variable.withString(MockFoodData.userId)]).getSingle();

    final count = existingCount.data['count'] as int;

    if (count == 0) {
      // 식사 기록 추가
      for (var meal in mealData) {
        await _db.into(_db.foodEntries).insert(
              FoodEntriesCompanion(
                userId: Value(meal['userId']),
                foodId: Value(meal['foodId']),
                portionGrams: Value(meal['portionGrams']),
                mealType: Value(meal['mealType']),
                timestamp: Value(meal['timestamp']),
                notes: Value(meal['notes']),
                // 영양 정보는 트리거나 서비스에서 자동 계산됨
              ),
            );
      }
      developer.log('✅ 식사 기록 ${mealData.length}건 추가 완료');

      // 일일 영양 요약 업데이트 (각 날짜별로)
      await _updateDailyNutritionSummaries();
    }
  }

  /// 즐겨찾는 포션 초기화
  Future<void> _initializeFavoritePortions() async {
    final portionData = MockFoodData.getFavoritePortions();

    for (var portion in portionData) {
      // 중복 체크
      final existing = await (_db.select(_db.favoritePortions)
            ..where((fp) =>
                fp.userId.equals(portion['userId']) &
                fp.foodId.equals(portion['foodId']) &
                fp.portionGrams.equals(portion['portionGrams'])))
          .getSingleOrNull();

      if (existing == null) {
        await _db.into(_db.favoritePortions).insert(
              FavoritePortionsCompanion(
                userId: Value(portion['userId']),
                foodId: Value(portion['foodId']),
                portionGrams: Value(portion['portionGrams']),
                nickname: Value(portion['nickname']),
                usageCount: Value(portion['usageCount']),
              ),
            );
      }
    }
    developer.log('✅ 즐겨찾는 포션 ${portionData.length}건 추가 완료');
  }

  /// 사용자 음식 통계 초기화
  Future<void> _initializeUserFoodStatistics() async {
    final statsData = MockFoodData.getFoodStatistics();

    for (var stat in statsData) {
      // 중복 체크
      final existing = await (_db.select(_db.userFoodStatistics)
            ..where((ufs) =>
                ufs.userId.equals(stat['userId']) &
                ufs.foodId.equals(stat['foodId']) &
                ufs.foodType.equals(stat['foodType'])))
          .getSingleOrNull();

      if (existing == null) {
        await _db.into(_db.userFoodStatistics).insert(
              UserFoodStatisticsCompanion(
                userId: Value(stat['userId']),
                foodId: Value(stat['foodId']),
                foodType: Value(stat['foodType']),
                totalConsumptions: Value(stat['totalConsumptions']),
                averagePortionGrams: Value(stat['averagePortionGrams']),
                preferenceScore: Value(stat['preferenceScore']),
                firstConsumedAt: Value(stat['firstConsumedAt']),
                lastConsumedAt: Value(stat['lastConsumedAt']),
              ),
            );
      }
    }
    developer.log('✅ 음식 통계 ${statsData.length}건 추가 완료');
  }

  /// 일일 영양 요약 업데이트
  Future<void> _updateDailyNutritionSummaries() async {
    final now = DateTime.now();

    // 최근 7일간의 데이터 업데이트
    for (int dayOffset = 0; dayOffset < 7; dayOffset++) {
      final targetDate = DateTime(now.year, now.month, now.day)
          .subtract(Duration(days: dayOffset));
      await _updateDailyNutritionSummary(MockFoodData.userId, targetDate);
    }
    developer.log('✅ 일일 영양 요약 업데이트 완료');
  }

  /// 특정 날짜의 영양 요약 업데이트
  Future<void> _updateDailyNutritionSummary(
      String userId, DateTime date) async {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    final nextDay = normalizedDate.add(const Duration(days: 1));

    // 해당 날짜의 모든 식사 기록에서 영양 정보 합계 계산
    final result = await _db.customSelect('''
      SELECT 
        COALESCE(SUM(fe.portion_grams * f.kcal_per100g / 100), 0) as total_calories,
        COALESCE(SUM(fe.portion_grams * f.carbs_per100g / 100), 0) as total_carbs,
        COALESCE(SUM(fe.portion_grams * f.protein_per100g / 100), 0) as total_protein,
        COALESCE(SUM(fe.portion_grams * f.fat_per100g / 100), 0) as total_fat,
        COALESCE(SUM(fe.portion_grams * f.fiber_per100g / 100), 0) as total_fiber,
        SUM(CASE WHEN fe.meal_type = 'breakfast' THEN 1 ELSE 0 END) as breakfast_count,
        SUM(CASE WHEN fe.meal_type = 'lunch' THEN 1 ELSE 0 END) as lunch_count,
        SUM(CASE WHEN fe.meal_type = 'dinner' THEN 1 ELSE 0 END) as dinner_count,
        SUM(CASE WHEN fe.meal_type = 'snack' THEN 1 ELSE 0 END) as snack_count
      FROM food_entries fe
      JOIN foods f ON fe.food_id = f.id 
      WHERE fe.user_id = ? AND fe.timestamp >= ? AND fe.timestamp < ?
    ''', variables: [
      Variable.withString(userId),
      Variable.withDateTime(normalizedDate),
      Variable.withDateTime(nextDay),
    ]).getSingleOrNull();

    if (result != null) {
      // 사용자 목표 조회
      final userPref = await (_db.select(_db.userPreferences)
            ..where((up) => up.userId.equals(userId)))
          .getSingleOrNull();

      // 일일 요약 삽입 또는 업데이트
      await _db.into(_db.dailyNutritionSummaries).insertOnConflictUpdate(
            DailyNutritionSummariesCompanion(
              userId: Value(userId),
              date: Value(normalizedDate),
              calorieGoal: Value(userPref?.dailyCalorieGoal ?? 2000),
              carbsGoal: Value(userPref?.dailyCarbsGoal ?? 250),
              proteinGoal: Value(userPref?.dailyProteinGoal ?? 50),
              fatGoal: Value(userPref?.dailyFatGoal ?? 65),
              totalCalories: Value(
                  (result.data['total_calories'] as num?)?.toDouble() ?? 0),
              totalCarbs:
                  Value((result.data['total_carbs'] as num?)?.toDouble() ?? 0),
              totalProtein: Value(
                  (result.data['total_protein'] as num?)?.toDouble() ?? 0),
              totalFat:
                  Value((result.data['total_fat'] as num?)?.toDouble() ?? 0),
              totalFiber:
                  Value((result.data['total_fiber'] as num?)?.toDouble() ?? 0),
              breakfastCount:
                  Value((result.data['breakfast_count'] as num?)?.toInt() ?? 0),
              lunchCount:
                  Value((result.data['lunch_count'] as num?)?.toInt() ?? 0),
              dinnerCount:
                  Value((result.data['dinner_count'] as num?)?.toInt() ?? 0),
              snackCount:
                  Value((result.data['snack_count'] as num?)?.toInt() ?? 0),
              updatedAt: Value(DateTime.now()),
            ),
          );
    }
  }

  /// 데이터베이스 초기화 여부 확인
  Future<bool> isDataInitialized() async {
    try {
      // 사용자 설정 존재 여부 확인
      final userExists = await (_db.select(_db.userPreferences)
            ..where((up) => up.userId.equals(MockFoodData.userId)))
          .getSingleOrNull();

      if (userExists == null) return false;

      // 식사 기록 존재 여부 확인
      final mealCount = await _db.customSelect(
          'SELECT COUNT(*) as count FROM food_entries WHERE user_id = ?',
          variables: [Variable.withString(MockFoodData.userId)]).getSingle();

      return (mealCount.data['count'] as int) > 0;
    } catch (e) {
      return false;
    }
  }

  /// 테스트용 데이터 정리
  Future<void> clearAllMockData() async {
    await _db.transaction(() async {
      // 역순으로 데이터 삭제 (외래키 제약조건 때문에)
      await (_db.delete(_db.dailyNutritionSummaries)
            ..where((dns) => dns.userId.equals(MockFoodData.userId)))
          .go();

      await (_db.delete(_db.userFoodStatistics)
            ..where((ufs) => ufs.userId.equals(MockFoodData.userId)))
          .go();

      await (_db.delete(_db.favoritePortions)
            ..where((fp) => fp.userId.equals(MockFoodData.userId)))
          .go();

      await (_db.delete(_db.foodEntries)
            ..where((fe) => fe.userId.equals(MockFoodData.userId)))
          .go();

      await (_db.delete(_db.userPreferences)
            ..where((up) => up.userId.equals(MockFoodData.userId)))
          .go();

      developer.log('✅ Mock 데이터 정리 완료');
    });
  }

  /// 오늘 식사 기록 추가 (테스트용)
  Future<void> addTodayMockMeal() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // 오늘 아침식사가 없다면 추가
    final existingBreakfast = await (_db.select(_db.foodEntries)
          ..where((fe) =>
              fe.userId.equals(MockFoodData.userId) &
              fe.mealType.equals('breakfast') &
              fe.timestamp.isBiggerOrEqualValue(today) &
              fe.timestamp
                  .isSmallerThanValue(today.add(const Duration(days: 1)))))
        .getSingleOrNull();

    if (existingBreakfast == null) {
      await _db.into(_db.foodEntries).insert(
            FoodEntriesCompanion(
              userId: const Value(MockFoodData.userId),
              foodId: const Value(1), // 김치찌개
              portionGrams: const Value(150.0),
              mealType: const Value('breakfast'),
              timestamp: Value(today.add(const Duration(hours: 8))),
              notes: const Value('오늘 아침식사 - 김치찌개'),
            ),
          );

      // 영양 요약 업데이트
      await _updateDailyNutritionSummary(MockFoodData.userId, today);
      developer.log('✅ 오늘 아침식사 추가 완료');
    }
  }

  /// 활동 데이터 초기화
  Future<void> _initializeActivityData() async {
    // 1. 활동 목표 설정
    await _initializeActivityGoals();

    // 2. 일일 활동 데이터 추가
    await _initializeDailyActivities();

    // 3. 운동 세션 추가
    await _initializeWorkoutSessions();

    // 4. 체중 기록 추가
    await _initializeWeightRecords();
  }

  /// 활동 목표 초기화
  Future<void> _initializeActivityGoals() async {
    final goals = MockActivityData.getDailyGoals();

    final existing = await (_db.select(_db.activityGoals)
          ..where((ag) => ag.userId.equals(goals['userId'])))
        .getSingleOrNull();

    if (existing == null) {
      await _db.into(_db.activityGoals).insert(
            ActivityGoalsCompanion(
              userId: Value(goals['userId']),
              stepsGoal: Value(goals['stepsGoal']),
              caloriesBurnedGoal: Value(goals['caloriesBurnedGoal']),
              activeMinutesGoal: Value(goals['activeMinutesGoal']),
              workoutsPerWeekGoal: Value(goals['workoutsPerWeekGoal']),
              distanceGoal: Value(goals['distanceGoal']),
            ),
          );
      developer.log('✅ 활동 목표 추가 완료');
    }
  }

  /// 일일 활동 데이터 초기화
  Future<void> _initializeDailyActivities() async {
    final activities = MockActivityData.getWeeklyActivityData();

    for (var activity in activities) {
      // 중복 체크
      final existing = await (_db.select(_db.dailyActivities)
            ..where((da) =>
                da.userId.equals(activity['userId']) &
                da.date.equals(activity['date'])))
          .getSingleOrNull();

      if (existing == null) {
        await _db.into(_db.dailyActivities).insert(
              DailyActivitiesCompanion(
                userId: Value(activity['userId']),
                date: Value(activity['date']),
                steps: Value(activity['steps']),
                distanceMeters: Value(activity['distanceMeters']),
                caloriesBurned: Value(activity['caloriesBurned']),
                activeMinutes: Value(activity['activeMinutes']),
                lightActivityMinutes: Value(activity['lightActivityMinutes']),
                moderateActivityMinutes:
                    Value(activity['moderateActivityMinutes']),
                vigorousActivityMinutes:
                    Value(activity['vigorousActivityMinutes']),
                sedentaryMinutes: Value(activity['sedentaryMinutes']),
                heartRateAverage: Value(activity['heartRateAverage']),
                heartRateMax: Value(activity['heartRateMax']),
              ),
            );
      }
    }
    developer.log('✅ 일일 활동 ${activities.length}건 추가 완료');
  }

  /// 운동 세션 초기화
  Future<void> _initializeWorkoutSessions() async {
    final workouts = MockActivityData.getWorkoutSessions();

    for (var workout in workouts) {
      // 중복 체크
      final existing = await (_db.select(_db.workoutSessions)
            ..where((ws) =>
                ws.userId.equals(workout['userId']) &
                ws.startTime.equals(workout['startTime'])))
          .getSingleOrNull();

      if (existing == null) {
        await _db.into(_db.workoutSessions).insert(
              WorkoutSessionsCompanion(
                userId: Value(workout['userId']),
                type: Value(workout['type']),
                name: Value(workout['name']),
                startTime: Value(workout['startTime']),
                endTime: Value(workout['endTime']),
                duration: Value(workout['duration']),
                intensity: Value(workout['intensity']),
                caloriesBurned: Value(workout['caloriesBurned']),
                notes: Value(workout['notes']),
              ),
            );
      }
    }
    developer.log('✅ 운동 세션 ${workouts.length}건 추가 완료');
  }

  /// 체중 기록 초기화
  Future<void> _initializeWeightRecords() async {
    final weights = MockActivityData.getWeightHistory();

    for (var weight in weights) {
      // 중복 체크
      final existing = await (_db.select(_db.weightRecords)
            ..where((wr) =>
                wr.userId.equals(weight['userId']) &
                wr.date.equals(weight['date'])))
          .getSingleOrNull();

      if (existing == null) {
        await _db.into(_db.weightRecords).insert(
              WeightRecordsCompanion(
                userId: Value(weight['userId']),
                date: Value(weight['date']),
                weight: Value(weight['weight']),
                bodyFatPercentage: Value(weight['bodyFatPercentage']),
                muscleMass: Value(weight['muscleMass']),
                notes: Value(weight['notes']),
              ),
            );
      }
    }
    developer.log('✅ 체중 기록 ${weights.length}건 추가 완료');
  }
}
