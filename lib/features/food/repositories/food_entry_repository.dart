import 'package:drift/drift.dart';
import '../../../core/database/app_database.dart';

class FoodEntryRepository {
  final AppDatabase _db;

  FoodEntryRepository(this._db);
  
  AppDatabase get db => _db;

  /// 식사 기록 추가
  Future<int> createFoodEntry(FoodEntriesCompanion entry) async {
    return await _db.transaction(() async {
      final entryId = await _db.into(_db.foodEntries).insert(entry);
      
      // 일일 영양 요약 업데이트
      await _updateDailyNutritionSummary(
        entry.userId.value,
        entry.timestamp.value,
      );
      
      // 사용자 음식 통계 업데이트
      await _updateUserFoodStatistics(
        entry.userId.value,
        entry.foodId.value,
        entry.portionGrams.value,
        entry.timestamp.value,
      );
      
      return entryId;
    });
  }

  /// 식사 기록 수정
  Future<bool> updateFoodEntry(int id, FoodEntriesCompanion entry) async {
    return await _db.transaction(() async {
      // 기존 기록 조회
      final existingEntry = await (_db.select(_db.foodEntries)
            ..where((e) => e.id.equals(id)))
          .getSingleOrNull();
      
      if (existingEntry == null) return false;

      final updated = await (_db.update(_db.foodEntries)
            ..where((e) => e.id.equals(id)))
          .write(entry.copyWith(
            updatedAt: Value(DateTime.now()),
          ));

      if (updated > 0) {
        // 일일 영양 요약 재계산
        await _updateDailyNutritionSummary(
          existingEntry.userId,
          existingEntry.timestamp,
        );
      }

      return updated > 0;
    });
  }

  /// 식사 기록 삭제
  Future<bool> deleteFoodEntry(int id) async {
    return await _db.transaction(() async {
      // 기존 기록 조회
      final existingEntry = await (_db.select(_db.foodEntries)
            ..where((e) => e.id.equals(id)))
          .getSingleOrNull();
      
      if (existingEntry == null) return false;

      final deleted = await (_db.delete(_db.foodEntries)
            ..where((e) => e.id.equals(id)))
          .go();

      if (deleted > 0) {
        // 일일 영양 요약 재계산
        await _updateDailyNutritionSummary(
          existingEntry.userId,
          existingEntry.timestamp,
        );
        
        // 사용자 음식 통계 업데이트 (음수로)
        await _updateUserFoodStatistics(
          existingEntry.userId,
          existingEntry.foodId,
          -existingEntry.portionGrams, // 음수로 전달하여 통계에서 제거
          existingEntry.timestamp,
        );
      }

      return deleted > 0;
    });
  }

  /// 특정 날짜의 식사 기록 조회
  Future<List<FoodEntryWithFood>> getFoodEntriesByDate(
    String userId,
    DateTime date,
  ) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final query = _db.select(_db.foodEntries).join([
      innerJoin(
        _db.foods,
        _db.foods.id.equalsExp(_db.foodEntries.foodId),
      )
    ])
      ..where(
        _db.foodEntries.userId.equals(userId) &
        _db.foodEntries.timestamp.isBiggerOrEqualValue(startOfDay) &
        _db.foodEntries.timestamp.isSmallerThanValue(endOfDay)
      )
      ..orderBy([
        OrderingTerm(expression: _db.foodEntries.timestamp, mode: OrderingMode.asc)
      ]);

    final results = await query.get();
    return results.map((row) => FoodEntryWithFood(
      entry: row.readTable(_db.foodEntries),
      food: row.readTable(_db.foods),
    )).toList();
  }

  /// 특정 식사 타입의 기록 조회
  Future<List<FoodEntryWithFood>> getFoodEntriesByMealType(
    String userId,
    DateTime date,
    String mealType,
  ) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final query = _db.select(_db.foodEntries).join([
      innerJoin(
        _db.foods,
        _db.foods.id.equalsExp(_db.foodEntries.foodId),
      )
    ])
      ..where(
        _db.foodEntries.userId.equals(userId) &
        _db.foodEntries.mealType.equals(mealType) &
        _db.foodEntries.timestamp.isBiggerOrEqualValue(startOfDay) &
        _db.foodEntries.timestamp.isSmallerThanValue(endOfDay)
      )
      ..orderBy([
        OrderingTerm(expression: _db.foodEntries.timestamp, mode: OrderingMode.desc)
      ]);

    final results = await query.get();
    return results.map((row) => FoodEntryWithFood(
      entry: row.readTable(_db.foodEntries),
      food: row.readTable(_db.foods),
    )).toList();
  }

  /// 특정 기간의 식사 기록 조회
  Future<List<FoodEntryWithFood>> getFoodEntriesByDateRange(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final query = _db.select(_db.foodEntries).join([
      innerJoin(
        _db.foods,
        _db.foods.id.equalsExp(_db.foodEntries.foodId),
      )
    ])
      ..where(
        _db.foodEntries.userId.equals(userId) &
        _db.foodEntries.timestamp.isBiggerOrEqualValue(startDate) &
        _db.foodEntries.timestamp.isSmallerOrEqualValue(endDate)
      )
      ..orderBy([
        OrderingTerm(expression: _db.foodEntries.timestamp, mode: OrderingMode.desc)
      ]);

    final results = await query.get();
    return results.map((row) => FoodEntryWithFood(
      entry: row.readTable(_db.foodEntries),
      food: row.readTable(_db.foods),
    )).toList();
  }

  /// 일일 영양 요약 조회
  Future<DailyNutritionSummary?> getDailyNutritionSummary(
    String userId,
    DateTime date,
  ) async {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    
    return await (_db.select(_db.dailyNutritionSummaries)
          ..where((s) => 
            s.userId.equals(userId) & 
            s.date.equals(normalizedDate)))
        .getSingleOrNull();
  }

  /// 주간 영양 요약 조회
  Future<List<DailyNutritionSummary>> getWeeklyNutritionSummary(
    String userId,
    DateTime weekStart,
  ) async {
    final weekEnd = weekStart.add(const Duration(days: 7));
    
    return await (_db.select(_db.dailyNutritionSummaries)
          ..where((s) => 
            s.userId.equals(userId) & 
            s.date.isBiggerOrEqualValue(weekStart) & 
            s.date.isSmallerThanValue(weekEnd))
          ..orderBy([(s) => OrderingTerm(expression: s.date)]))
        .get();
  }

  /// 즐겨찾는 포션 추가/업데이트
  Future<int> addOrUpdateFavoritePortion(
    String userId,
    int foodId,
    double portionGrams, {
    String? nickname,
  }) async {
    // 기존 즐겨찾기 확인
    final existing = await (_db.select(_db.favoritePortions)
          ..where((fp) => 
            fp.userId.equals(userId) & 
            fp.foodId.equals(foodId) & 
            fp.portionGrams.equals(portionGrams)))
        .getSingleOrNull();

    if (existing != null) {
      // 기존 것이 있으면 사용 횟수 증가
      await (_db.update(_db.favoritePortions)
            ..where((fp) => fp.id.equals(existing.id)))
          .write(FavoritePortionsCompanion(
            usageCount: Value(existing.usageCount + 1),
            lastUsedAt: Value(DateTime.now()),
            nickname: nickname != null ? Value(nickname) : const Value.absent(),
          ));
      return existing.id;
    } else {
      // 새로 추가
      return await _db.into(_db.favoritePortions).insert(
        FavoritePortionsCompanion(
          userId: Value(userId),
          foodId: Value(foodId),
          portionGrams: Value(portionGrams),
          nickname: Value(nickname),
        ),
      );
    }
  }

  /// 즐겨찾는 포션 조회
  Future<List<FavoritePortionWithFood>> getFavoritePortions(
    String userId, {
    int? foodId,
    int limit = 20,
  }) async {
    final query = _db.select(_db.favoritePortions).join([
      innerJoin(
        _db.foods,
        _db.foods.id.equalsExp(_db.favoritePortions.foodId),
      )
    ])
      ..where(_db.favoritePortions.userId.equals(userId))
      ..orderBy([
        OrderingTerm(expression: _db.favoritePortions.usageCount, mode: OrderingMode.desc),
        OrderingTerm(expression: _db.favoritePortions.lastUsedAt, mode: OrderingMode.desc),
      ])
      ..limit(limit);

    if (foodId != null) {
      query.where(_db.favoritePortions.foodId.equals(foodId));
    }

    final results = await query.get();
    return results.map((row) => FavoritePortionWithFood(
      favoritePortion: row.readTable(_db.favoritePortions),
      food: row.readTable(_db.foods),
    )).toList();
  }

  /// 일일 영양 요약 업데이트 (내부 메서드)
  Future<void> _updateDailyNutritionSummary(String userId, DateTime date) async {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    final nextDay = normalizedDate.add(const Duration(days: 1));

    // 해당 날짜의 모든 식사 기록 합계 계산
    final result = await _db.customSelect('''
      SELECT 
        SUM(total_calories) as total_calories,
        SUM(total_carbs) as total_carbs,
        SUM(total_protein) as total_protein,
        SUM(total_fat) as total_fat,
        SUM(total_fiber) as total_fiber,
        SUM(CASE WHEN meal_type = 'breakfast' THEN 1 ELSE 0 END) as breakfast_count,
        SUM(CASE WHEN meal_type = 'lunch' THEN 1 ELSE 0 END) as lunch_count,
        SUM(CASE WHEN meal_type = 'dinner' THEN 1 ELSE 0 END) as dinner_count,
        SUM(CASE WHEN meal_type = 'snack' THEN 1 ELSE 0 END) as snack_count
      FROM food_entries 
      WHERE user_id = ? AND timestamp >= ? AND timestamp < ?
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

      await _db.into(_db.dailyNutritionSummaries).insertOnConflictUpdate(
        DailyNutritionSummariesCompanion(
          userId: Value(userId),
          date: Value(normalizedDate),
          calorieGoal: Value(userPref?.dailyCalorieGoal ?? 2000),
          carbsGoal: Value(userPref?.dailyCarbsGoal ?? 250),
          proteinGoal: Value(userPref?.dailyProteinGoal ?? 50),
          fatGoal: Value(userPref?.dailyFatGoal ?? 65),
          totalCalories: Value((result.data['total_calories'] as num?)?.toDouble() ?? 0),
          totalCarbs: Value((result.data['total_carbs'] as num?)?.toDouble() ?? 0),
          totalProtein: Value((result.data['total_protein'] as num?)?.toDouble() ?? 0),
          totalFat: Value((result.data['total_fat'] as num?)?.toDouble() ?? 0),
          totalFiber: Value((result.data['total_fiber'] as num?)?.toDouble() ?? 0),
          breakfastCount: Value((result.data['breakfast_count'] as num?)?.toInt() ?? 0),
          lunchCount: Value((result.data['lunch_count'] as num?)?.toInt() ?? 0),
          dinnerCount: Value((result.data['dinner_count'] as num?)?.toInt() ?? 0),
          snackCount: Value((result.data['snack_count'] as num?)?.toInt() ?? 0),
          updatedAt: Value(DateTime.now()),
        ),
      );
    }
  }

  /// 사용자 음식 통계 업데이트 (내부 메서드)
  Future<void> _updateUserFoodStatistics(
    String userId,
    int foodId,
    double portionGrams,
    DateTime consumedAt,
  ) async {
    final existing = await (_db.select(_db.userFoodStatistics)
          ..where((ufs) => 
            ufs.userId.equals(userId) & 
            ufs.foodId.equals(foodId) & 
            ufs.foodType.equals('standard')))
        .getSingleOrNull();

    if (existing != null) {
      final newTotalConsumptions = portionGrams > 0 ? 
          existing.totalConsumptions + 1 : 
          (existing.totalConsumptions - 1).clamp(0, double.infinity).toInt();
      
      final newAverageGrams = newTotalConsumptions > 0 ? 
          ((existing.averagePortionGrams * existing.totalConsumptions + portionGrams) / newTotalConsumptions).abs() :
          0.0;

      await (_db.update(_db.userFoodStatistics)
            ..where((ufs) => ufs.id.equals(existing.id)))
          .write(UserFoodStatisticsCompanion(
            totalConsumptions: Value(newTotalConsumptions),
            averagePortionGrams: Value(newAverageGrams),
            lastConsumedAt: portionGrams > 0 ? Value(consumedAt) : const Value.absent(),
            updatedAt: Value(DateTime.now()),
          ));
    } else if (portionGrams > 0) {
      // 새로운 통계 생성 (삭제가 아닌 경우에만)
      await _db.into(_db.userFoodStatistics).insert(
        UserFoodStatisticsCompanion(
          userId: Value(userId),
          foodId: Value(foodId),
          foodType: const Value('standard'),
          totalConsumptions: const Value(1),
          averagePortionGrams: Value(portionGrams),
          firstConsumedAt: Value(consumedAt),
          lastConsumedAt: Value(consumedAt),
        ),
      );
    }
  }
}

/// 식사 기록과 음식 정보를 함께 담는 클래스
class FoodEntryWithFood {
  final FoodEntry entry;
  final Food food;

  const FoodEntryWithFood({
    required this.entry,
    required this.food,
  });
}

/// 즐겨찾는 포션과 음식 정보를 함께 담는 클래스
class FavoritePortionWithFood {
  final FavoritePortion favoritePortion;
  final Food food;

  const FavoritePortionWithFood({
    required this.favoritePortion,
    required this.food,
  });
}