import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../core/database/app_database.dart';
import '../../features/food/repositories/food_repository.dart';
import '../../features/food/repositories/food_entry_repository.dart';
import '../../features/food/repositories/recognition_repository.dart';
import '../../core/database/repositories/activity_repository.dart';
import '../../shared/providers/app_providers.dart';

/// 앱 데이터베이스 싱글톤 프로바이더
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

/// 음식 Repository 프로바이더
final foodRepositoryProvider = Provider<FoodRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return FoodRepository(db);
});

/// 식사 기록 Repository 프로바이더
final foodEntryRepositoryProvider = Provider<FoodEntryRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return FoodEntryRepository(db);
});

/// AI 인식 Repository 프로바이더
final recognitionRepositoryProvider = Provider<RecognitionRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return RecognitionRepository(db);
});

/// 활동 Repository 프로바이더
final activityRepositoryProvider = Provider<ActivityRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return ActivityRepository(db);
});

/// 현재 사용자 ID 프로바이더 (임시 구현)
/// 현재 사용자 ID 프로바이더 (인증 시스템 연동)
final currentUserIdProvider = Provider<String>((ref) {
  final user = ref.watch(authStateProvider).user;
  return user?.id ?? '';
});

/// 데이터베이스 상태 프로바이더
final databaseHealthProvider = FutureProvider<bool>((ref) async {
  final db = ref.watch(appDatabaseProvider);
  return await db.isDatabaseHealthy();
});

/// 데이터베이스 통계 프로바이더
final databaseStatsProvider = FutureProvider<Map<String, int>>((ref) async {
  final db = ref.watch(appDatabaseProvider);
  return await db.getDatabaseStats();
});

/// 데이터베이스 초기화 완료 상태를 관리하는 StateNotifier
class DatabaseInitializationNotifier extends StateNotifier<AsyncValue<bool>> {
  DatabaseInitializationNotifier(this._db) : super(const AsyncValue.loading()) {
    _initialize();
  }

  final AppDatabase _db;

  Future<void> _initialize() async {
    try {
      // 데이터베이스 상태 확인
      final isHealthy = await _db.isDatabaseHealthy();
      state = AsyncValue.data(isHealthy);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> reinitialize() async {
    state = const AsyncValue.loading();
    await _initialize();
  }
}

/// 데이터베이스 초기화 상태 프로바이더
final databaseInitializationProvider =
    StateNotifierProvider<DatabaseInitializationNotifier, AsyncValue<bool>>(
        (ref) {
  final db = ref.watch(appDatabaseProvider);
  return DatabaseInitializationNotifier(db);
});

/// 사용자별 설정을 관리하는 StateNotifier
class UserPreferencesNotifier
    extends StateNotifier<AsyncValue<UserPreference?>> {
  UserPreferencesNotifier(this._db, this._userId)
      : super(const AsyncValue.loading()) {
    _loadUserPreferences();
  }

  final AppDatabase _db;
  final String _userId;

  Future<void> _loadUserPreferences() async {
    try {
      final preferences = await (_db.select(_db.userPreferences)
            ..where((up) => up.userId.equals(_userId)))
          .getSingleOrNull();
      state = AsyncValue.data(preferences);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updatePreferences(UserPreferencesCompanion preferences) async {
    try {
      state = const AsyncValue.loading();

      await _db.into(_db.userPreferences).insertOnConflictUpdate(
            preferences.copyWith(userId: Value(_userId)),
          );

      await _loadUserPreferences();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateDailyGoals({
    double? calorieGoal,
    double? carbsGoal,
    double? proteinGoal,
    double? fatGoal,
    double? fiberGoal,
  }) async {
    await updatePreferences(UserPreferencesCompanion(
      dailyCalorieGoal:
          calorieGoal != null ? Value(calorieGoal) : const Value.absent(),
      dailyCarbsGoal:
          carbsGoal != null ? Value(carbsGoal) : const Value.absent(),
      dailyProteinGoal:
          proteinGoal != null ? Value(proteinGoal) : const Value.absent(),
      dailyFatGoal: fatGoal != null ? Value(fatGoal) : const Value.absent(),
      dailyFiberGoal:
          fiberGoal != null ? Value(fiberGoal) : const Value.absent(),
      updatedAt: Value(DateTime.now()),
    ));
  }
}

/// 사용자 설정 프로바이더
final userPreferencesProvider =
    StateNotifierProvider<UserPreferencesNotifier, AsyncValue<UserPreference?>>(
        (ref) {
  final db = ref.watch(appDatabaseProvider);
  final userId = ref.watch(currentUserIdProvider);
  return UserPreferencesNotifier(db, userId);
});

/// 특정 날짜의 일일 영양 요약 프로바이더
final dailyNutritionSummaryProvider =
    FutureProvider.family<DailyNutritionSummary?, DateTime>((ref, date) async {
  final repository = ref.watch(foodEntryRepositoryProvider);
  final userId = ref.watch(currentUserIdProvider);
  return await repository.getDailyNutritionSummary(userId, date);
});

/// 오늘의 영양 요약 프로바이더 (자주 사용되는 것)
final todayNutritionSummaryProvider =
    FutureProvider<DailyNutritionSummary?>((ref) async {
  final today = DateTime.now();
  return ref.watch(dailyNutritionSummaryProvider(today).future);
});

/// 주간 영양 요약 프로바이더
final weeklyNutritionSummaryProvider =
    FutureProvider.family<List<DailyNutritionSummary>, DateTime>(
        (ref, weekStart) async {
  final repository = ref.watch(foodEntryRepositoryProvider);
  final userId = ref.watch(currentUserIdProvider);
  return await repository.getWeeklyNutritionSummary(userId, weekStart);
});

/// 특정 날짜의 식사 기록 프로바이더
final foodEntriesByDateProvider =
    FutureProvider.family<List<FoodEntryWithFood>, DateTime>((ref, date) async {
  final repository = ref.watch(foodEntryRepositoryProvider);
  final userId = ref.watch(currentUserIdProvider);
  return await repository.getFoodEntriesByDate(userId, date);
});

/// 오늘의 식사 기록 프로바이더
final todayFoodEntriesProvider =
    FutureProvider<List<FoodEntryWithFood>>((ref) async {
  final today = DateTime.now();
  return ref.watch(foodEntriesByDateProvider(today).future);
});

/// 특정 식사 타입의 기록 프로바이더
final foodEntriesByMealTypeProvider = FutureProvider.family<
    List<FoodEntryWithFood>,
    ({DateTime date, String mealType})>((ref, params) async {
  final repository = ref.watch(foodEntryRepositoryProvider);
  final userId = ref.watch(currentUserIdProvider);
  return await repository.getFoodEntriesByMealType(
      userId, params.date, params.mealType);
});

/// 즐겨찾는 포션 프로바이더
final favoritePortionsProvider =
    FutureProvider.family<List<FavoritePortionWithFood>, int?>(
        (ref, foodId) async {
  final repository = ref.watch(foodEntryRepositoryProvider);
  final userId = ref.watch(currentUserIdProvider);
  return await repository.getFavoritePortions(userId, foodId: foodId);
});

/// 인기 음식 프로바이더
final popularFoodsProvider = FutureProvider<List<Food>>((ref) async {
  final repository = ref.watch(foodRepositoryProvider);
  final userId = ref.watch(currentUserIdProvider);
  return await repository.getPopularFoods(userId);
});

/// 최근 섭취 음식 프로바이더
final recentFoodsProvider = FutureProvider<List<Food>>((ref) async {
  final repository = ref.watch(foodRepositoryProvider);
  final userId = ref.watch(currentUserIdProvider);
  return await repository.getRecentFoods(userId);
});

/// 추천 음식 프로바이더
final recommendedFoodsProvider =
    FutureProvider.family<List<Food>, String>((ref, mealType) async {
  final repository = ref.watch(foodRepositoryProvider);
  final userId = ref.watch(currentUserIdProvider);
  return await repository.getRecommendedFoods(userId, mealType);
});

/// AI 인식 이력 프로바이더
final recognitionHistoriesProvider = FutureProvider.family<
    List<RecognitionHistoryWithResults>,
    ({int limit, int offset})>((ref, params) async {
  final repository = ref.watch(recognitionRepositoryProvider);
  final userId = ref.watch(currentUserIdProvider);
  return await repository.getRecognitionHistories(
    userId,
    limit: params.limit,
    offset: params.offset,
  );
});

/// 최근 AI 인식 이력 프로바이더 (기본 20개)
final recentRecognitionHistoriesProvider =
    FutureProvider<List<RecognitionHistoryWithResults>>((ref) async {
  return ref.watch(recognitionHistoriesProvider((limit: 20, offset: 0)).future);
});

/// 특정 날짜의 AI 인식 이력 프로바이더
final recognitionHistoriesByDateProvider =
    FutureProvider.family<List<RecognitionHistoryWithResults>, DateTime>(
        (ref, date) async {
  final repository = ref.watch(recognitionRepositoryProvider);
  final userId = ref.watch(currentUserIdProvider);
  return await repository.getRecognitionHistoriesByDate(userId, date);
});

/// AI 인식 성능 통계 프로바이더
final recognitionStatisticsProvider = FutureProvider.family<
    RecognitionStatistics,
    ({DateTime? startDate, DateTime? endDate})>((ref, params) async {
  final repository = ref.watch(recognitionRepositoryProvider);
  final userId = ref.watch(currentUserIdProvider);
  return await repository.getRecognitionStatistics(
    userId,
    startDate: params.startDate,
    endDate: params.endDate,
  );
});

/// 자주 인식되는 음식 TOP 프로바이더
final topRecognizedFoodsProvider =
    FutureProvider<List<FoodRecognitionFrequency>>((ref) async {
  final repository = ref.watch(recognitionRepositoryProvider);
  final userId = ref.watch(currentUserIdProvider);
  return await repository.getTopRecognizedFoods(userId);
});

/// 음식 검색 결과를 위한 StateNotifier
class FoodSearchNotifier extends StateNotifier<AsyncValue<List<Food>>> {
  FoodSearchNotifier(this._repository) : super(const AsyncValue.data([]));

  final FoodRepository _repository;

  Future<void> searchFoods(String query) async {
    if (query.trim().isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }

    state = const AsyncValue.loading();
    try {
      final results = await _repository.searchFoods(query);
      state = AsyncValue.data(results);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void clearSearch() {
    state = const AsyncValue.data([]);
  }
}

/// 음식 검색 프로바이더
final foodSearchProvider =
    StateNotifierProvider<FoodSearchNotifier, AsyncValue<List<Food>>>((ref) {
  final repository = ref.watch(foodRepositoryProvider);
  return FoodSearchNotifier(repository);
});

/// 카테고리 목록 프로바이더
final foodCategoriesProvider = FutureProvider<List<String>>((ref) async {
  final repository = ref.watch(foodRepositoryProvider);
  return await repository.getCategories();
});

/// 카테고리별 음식 프로바이더
final foodsByCategoryProvider =
    FutureProvider.family<List<Food>, String>((ref, category) async {
  final repository = ref.watch(foodRepositoryProvider);
  return await repository.getFoodsByCategory(category);
});

/// 음식 상세 정보 프로바이더
final foodDetailProvider =
    FutureProvider.family<FoodDetail?, int>((ref, foodId) async {
  final repository = ref.watch(foodRepositoryProvider);
  return await repository.getFoodDetail(foodId);
});
